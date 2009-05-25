
Entonces /^debería ver el mensaje (.*)$/ do|messages_id|
  chain = []
  messages_id.split(' ').each do |message_id|
    chain << message_id.strip.slice(1..-1).to_sym
  end
  message = qt(chain)
  Entonces %(debería ver "#{message}")
end

Dado /^que existen las provincias "([^\"]*)"$/ do |list|
  list.split(', ').each do |provincia|
    Provincia.create!(:name => provincia)
  end
end
