FactoryGirl.define do
  factory :user do
    email
    password 'password'
    password_confirmation {|u| u.password }
    association :profile, factory: :profile, strategy: :build
  end
end
