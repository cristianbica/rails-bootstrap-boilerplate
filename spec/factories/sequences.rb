FactoryGirl.define do

  sequence :email do |n|
    "email_#{n}@domain.com"
  end

end
