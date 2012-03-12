class Profile < ActiveRecord::Base

  belongs_to :user, inverse_of: :profile 
  attr_accessible :full_name, :dob, :city, :country
  validates_uniqueness_of :user_id
end
