class Profile < ActiveRecord::Base

  belongs_to :user
  attr_accessible :full_name, :dob, :city, :country

end
