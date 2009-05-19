class User < ActiveRecord::Base
  has_one :survey
  acts_as_authentic
  validates_presence_of :question, :answer
  validates_uniqueness_of :username

  after_create :create_survey

  private
  def create_survey
    Survey.create!(:user_id => self.id)
  end
end
