class Enquiry < ActiveRecord::Base
  belongs_to :user
  belongs_to :package
  has_many :notifications, as: :notifiable, dependent: :destroy

  def self.get_enquiry user, package
  	where(:user_id=> user, :package_id => package).last
  end
end
