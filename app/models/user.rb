class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  
  has_one :profile, dependent: :destroy
  has_many :packages, dependent: :destroy
  has_many :crms, dependent: :destroy
  has_many :my_crms, :class_name => "Crm", :through => :packages, :source => :crms
  has_many :wishlists, dependent: :destroy
  has_many :packages_for_compare, :class_name=> 'Comparision', dependent: :destroy
  has_many :enquiries, dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true
  has_many :notifications, dependent: :destroy
  has_many :my_notifications, -> { where(is_viewed: false) }, class_name: 'Notification', foreign_key: "reciever", dependent: :destroy

  CATEGORIES = ['Family','Budget','Romantic','Luxury','Adventure','Offbeat','Chilling','History','Spa and Wellness','Religious','Food & Drinks','Others'] 
  SPECILIZED = ['MICE','Inbound','Outbound','FIT','Others']
  FILTER_BY = ['Name','Destination']

  scope :supplier, -> {where(:role => 'supplier')}

  def my_packages_ids
  	self.packages.pluck(:id)
  end

  def add_to_wishlist package_ids
    wishlist = self.wishlist
    if wishlist
      package_ids = (wishlist.package_ids.split(',') + package_ids).uniq
      wishlist.update_attributes(:package_ids => package_ids)
    else
      self.create_wishlist(:package_ids => package_ids)
    end
  end

  def add_to_crm package_id, type_of_request
    crm = self.crms.find_by_package_id(package_id)
    if crm
      unless crm.visit_for.delete(',').split(' ').include? type_of_request
        crm.update_attributes(:visit_for => (crm.visit_for == '' ? type_of_request : "#{crm.visit_for}, #{type_of_request}"))
      end
    else
      package = Package.find_by_id(package_id)
      cities = package.cities
      self.crms.create(:package_id => package.id, :name => package.itinerary_name, :destination => cities.last.city_name,
       :start_from => cities.first.city_name, :visit_date => Date.today, 
       :assigned_to => 'demo@email.com', :visit_for => type_of_request, :is_customize_request => true,
       :status => 'Pending')
    end
  end

   def remove_from_crm package_id, type_of_request
    crm = self.crms.find_by_package_id(package_id)
    if crm
      arr = crm.visit_for.delete(',').split(' ')
      if arr.include?(type_of_request)
        if arr.length == 1
          self.crms.find_by_package_id(package_id).destroy
        else
          arr -=Array(type_of_request)
          crm.update_attributes(:visit_for =>arr.join(', '))
        end
      end
    end
  end

end
