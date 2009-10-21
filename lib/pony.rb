# modified version of pony container portions of:
# http://github.com/openrain/action_mailer_tls
# http://github.com/adamwiggins/pony


require 'rubygems'
require 'net/smtp'
begin
	require 'tmail'
rescue LoadError
	require 'actionmailer'
end

require "openssl"
require "net/smtp"

Net::SMTP.class_eval do
  private
  def do_start(helodomain, user, secret, authtype)
    raise IOError, 'SMTP session already started' if @started

    if RUBY_VERSION == '1.8.6'
      check_auth_args user, secret, authtype if user or secret
    elsif RUBY_VERSION == '1.8.7'
      check_auth_args user, secret if user or secret
    else
      raise Exception, 'Ruby version not supported'
    end

    sock = timeout(@open_timeout) { TCPSocket.open(@address, @port) }
    @socket = Net::InternetMessageIO.new(sock)
    @socket.read_timeout = 60 #@read_timeout

    check_response(critical { recv_response() })
    do_helo(helodomain)

    if starttls
      raise 'openssl library not installed' unless defined?(OpenSSL)
      ssl = OpenSSL::SSL::SSLSocket.new(sock)
      ssl.sync_close = true
      ssl.connect
      @socket = Net::InternetMessageIO.new(ssl)
      @socket.read_timeout = 60 #@read_timeout
      do_helo(helodomain)
    end

    authenticate user, secret, authtype if user
    @started = true
  ensure
    unless @started
      # authentication failed, cancel connection.
      @socket.close if not @started and @socket and not @socket.closed?
      @socket = nil
    end
  end

  def do_helo(helodomain)
    begin
      if @esmtp
        ehlo helodomain
      else
        helo helodomain
      end
    rescue Net::ProtocolError
      if @esmtp
        @esmtp = false
        @error_occured = false
        retry
      end
      raise
    end
  end

  def starttls
    getok('STARTTLS') rescue return false
    return true
  end

  def quit
    begin
      getok('QUIT')
    rescue EOFError
    end
  end
end

module Pony
	def self.mail(options)
		raise(ArgumentError, ":to is required") unless options[:to]

		via = options.delete(:via)
		if via.nil?
			transport build_tmail(options)
		else
			if via_options.include?(via.to_s)
				send("transport_via_#{via}", build_tmail(options), options)
			else
				raise(ArgumentError, ":via must be either smtp or sendmail")
			end
		end
	end

	def self.build_tmail(options)
		mail = TMail::Mail.new
		mail.to = options[:to]
		mail.from = options[:from] || 'pony@unknown'
		mail.subject = options[:subject]
		mail.body = options[:body] || ""
		mail
	end

	def self.sendmail_binary
		@sendmail_binary ||= `which sendmail`.chomp
	end

	def self.transport(tmail)
		if File.executable? sendmail_binary
			transport_via_sendmail(tmail)
		else
			transport_via_smtp(tmail)
		end
	end

	def self.via_options
		%w(sendmail smtp)
	end

	def self.transport_via_sendmail(tmail, options={})
		IO.popen('-', 'w+') do |pipe|
			if pipe
				pipe.write(tmail.to_s)
			else
				exec(sendmail_binary, *tmail.to)
			end
		end
	end

	def self.transport_via_smtp(tmail, options={:smtp => {}})
		default_options = {:smtp => { :host => 'localhost', :port => '25', :domain => 'localhost.localdomain' }}
		o = default_options[:smtp].merge(options[:smtp])
		smtp = Net::SMTP.new(o[:host], o[:port])
		if o.include?(:auth)
			smtp.start(o[:domain], o[:user], o[:password], o[:auth])
		else
			smtp.start(o[:domain])
		end
		smtp.send_message tmail.to_s, tmail.from, tmail.to
		smtp.finish
	end
end
