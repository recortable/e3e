
class UserSurvey
  def self.find(user)
    id = user.is_a?(Numeric) ? user : user.id
    return UserSurvey.new(id)
  end

  def initialize(user_id)
    @user_id = user_id
    @questions = {}
    @answers = {}

    q = Question.all
    a = Answer.all(:include => :question,
      :conditions => {:user_id => user_id, :question_id => q})

    a.each do |answer|
      name = answer.question.name
      @questions[name] = answer.question
      @answers[name] = answer
      instance_eval("def #{name}()\n '#{answer.value}'\n end")
    end

  end

  def update(params)
    Answer.transaction do
      params.each_key do |name|
        answer = answer(name)
        answer.value = params[name]
        answer.save
      end
    end
  end

  def id
    @user_id
  end

  def to_param
    @user_id
  end

  def new_record?
    false
  end

  def questions
    @questions.values
  end

  def answers
    @answers.values
  end

  def answer(name)
    @answers[name]  ||= Answer.find_or_create_by_question_id_and_user_id(question(name).id, @user_id)
  end

  def question(name)
    @questions[name] ||= Question.find_or_create_by_name(name.to_s)
  end

  def method_missing(name, *args)
    answer(name.to_s).value
  end
end