FactoryGirl.define do

  factory :profile do
    full_name { Faker::Name.name }
    dob { (rand(30)+18).years.ago + rand(100).days + rand(10000).minutes }
    city { Faker::Address.city }
    country 'United States'
  end

end
