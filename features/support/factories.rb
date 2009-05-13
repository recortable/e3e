
Factory.define :user do |f|
  f.sequence(:username) { |n| "user#{n}" }
  f.password "secret"
  f.password_confirmation { |u| u.password }
  f.sequence(:question) { |n| "question#{n}" }
  f.sequence(:answer) { |n| "answer#{n}" }
end
