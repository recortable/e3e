
Factory.define :user do |f|
  f.sequence(:username) { |n| "user#{n}" }
  f.password "secret"
  f.password_confirmation { |u| u.password }
  f.sequence(:question) { |n| "question#{n}" }
  f.sequence(:answer) { |n| "answer#{n}" }
end

Factory.define :admin do |f|
  f.sequence(:email) { |n| "admin#{n}@e3e.org" }
  f.password "secret"
  f.password_confirmation { |u| u.password }
end
