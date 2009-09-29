
class PasswordReminder
  attr_accessor :username

  def initialize(user = nil, user_answer = nil)
    @user = user
    @user_answer = user_answer
    unless @user.nil?
      self.username = user.username
    end
  end

  def question
    @user.question unless @user.nil?
  end

  def valid?
    !@user_answer.nil? && @user_answer == @user.answer
  end

  def self.find(params = {})
    user = User.find_by_username(params[:username])
    PasswordReminder.new(user, params[:answer])
  end

  def new_record?
    true
  end

  def user
    @user
  end

  def answer=(answer)
    @user_answer = answer
  end

  def answer
    valid? ? @user.answer : @user_answer
  end

  def password
    @user.password
  end

end