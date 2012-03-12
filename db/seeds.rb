ActiveRecord::Base.connection.execute("TRUNCATE users")
ActiveRecord::Base.connection.execute("TRUNCATE profiles")

10.times do
  FactoryGirl.create :user
end
