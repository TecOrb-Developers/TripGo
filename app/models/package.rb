class Package < ActiveRecord::Base
  @ids = []
  belongs_to :user
  has_many :pictures, as: :imagiable, dependent: :destroy
  has_many :cities, dependent: :destroy
  has_many :transports, dependent: :destroy
  has_many :city_transports
  has_many :enquiries, dependent: :destroy
  has_many :hotels, dependent: :destroy
  has_one :inclusion, dependent: :destroy
  accepts_nested_attributes_for :pictures,:cities,:hotels, allow_destroy: true
  after_create :add_inclusion

  has_many :sight_scenes, dependent: :destroy
  has_many :itineraries, dependent: :destroy
  has_many :crms, dependent: :destroy
  has_one :meal, dependent: :destroy

  scope :today_onwards, -> {where("start_date >= '#{Date.current}'")}
  attr_accessor :is_in_wishlist
  attr_accessor :is_in_comparelist
  attr_accessor :similarity_score
  has_many :notifications, dependent: :destroy

# HOLIDAYS DESTINATION TYPE
HOLIDAYS = ['Beaches','Deserts','Hills and Valleys','Rivers and Lakes','Wildlife','Religious','Heritage']
HOLIDAY_TYPES = ['Romantic','Spa and Wellness','Family','Budget','Adventure','Luxury','Food and Drinks','Sports','Friends']
ROOM_SHARING = ['2 Person per Room','3 Person per Room','4 Person per Room','Other']

HOLIDAY_TYPES_ICON= ['ic_romantic', 'ic_spa', 'ic_family', 'ic_chilling', 'ic_adventure', 'ic_food', 'ic_food', 'ic_sports']
HOLIDAYS_ICON= ['ic_beach', 'ic_hills', 'ic_wildlife', 'ic_desert', 'ic_heritage', 'ic_rivers', 'ic_religious', 'ic_desert']
INCLUSIONS = {'Local Transport'=> 'CT', 'Sightseeing'=> 'SI' }
INCLUSIONS_ICON = ['ic_lt', 'ic_sight']
SORT_BY = {'Price'=> 'price_per_person', 'Duration' => 'package_duration', 'Destination'=> 'city_name'}

def clone_with_associations
    # zero level dup
    new_package = self.dup
    new_package.itinerary_name = "Copy of #{self.itinerary_name}"
    # new_package.pictures = self.pictures.dup
    new_package.save

    picturez = []
    cityz = []
    transportz = []
    city_transportz = []
    sight_scenez = []
    itinerariez = []
    hotelz = []

    self.pictures.each do |picture|
      picture_dup = picture.dup
      picture_dup.imagiable_id = new_package.id
      picture_dup.save
      picturez << picture_dup 
    end

    self.cities.each do |city|
      city_dup = city.dup
      city_dup.package_id = new_package.id
      city_dup.save
      cityz << city_dup 
    end

    self.transports.order(:created_at).each do |transport|
      transport_dup = transport.dup
      transport_dup.package_id = new_package.id
      transport_dup.save
      transportz << transport_dup 
    end

    self.hotels.each do |hotel|
      hotel_dup = hotel.dup
      hotel_dup.package_id = new_package.id
      hotel_dup.save
      hotelz << hotel_dup 
    end

    self.city_transports.each do |city_transport|
      city_transport_dup = city_transport.dup
      city_transport_dup.package_id = new_package.id
      city_transport_dup.save
      city_transportz << city_transport_dup 
    end

    city_transportz.each_with_index do |city_transport, index|
      city_transport.city_id = cityz[index + 1].id
      city_transport.save
    end

    self.sight_scenes.each do |sight_scene|
      sight_scene_dup = sight_scene.dup
      sight_scene_dup.package_id = new_package.id
      sight_scene_dup.save
      sight_scenez << sight_scene_dup 
    end

    self.itineraries.each do |itinerary|
      itinerary_dup = itinerary.dup
      itinerary_dup.package_id = new_package.id
      itinerary_dup.save
      itinerariez << itinerary_dup 
    end

    meal_dup = self.meal.dup
    meal_dup.package_id = new_package.id
    meal_dup.save

    inclusion_dup = self.inclusion.dup
    inclusion_dup.package_id = new_package.id
    inclusion_dup.save

    new_package.pictures = picturez
    new_package.cities = cityz
    new_package.transports = transportz
    new_package.hotels = hotelz
    new_package.city_transports = city_transportz
    new_package.sight_scenes = sight_scenez
    new_package.itineraries = itinerariez
    new_package.meal = meal_dup
    new_package.inclusion = inclusion_dup

    new_package
  end

  def create_transport(type)
    @cities = self.cities
    if type == 'create' 
    	manage_transports
    elsif @cities.order(:created_at).pluck(:city_name) == self.transports.order(:created_at).pluck(:start).reverse
      self.transports.destroy_all
      manage_transports
    else
      @cities = @cities.order(:created_at).pluck(:city_name)
      @city_to_update = self.transports.order(:created_at).pluck(:start)
      @city_removes = @city_to_update - @cities
      @add_city = @cities - @city_to_update
      unless @city_removes.blank?
        @city_removes.each_with_index do |city,index|
          end_city = @city_to_update[@city_to_update.index(city) + 1].nil? ? @city_to_update.first : @city_to_update[@city_to_update.index(city) + 1]
          self.transports.where(:end => city).first.update_attributes(:end => end_city,:transport_mode => "Flights", :transport_name => "",:transfer_section => "not_included",:transfer_mode => "",:time_of_onward => [])
          self.transports.where(:start => city).destroy_all
        end
      end
      unless @add_city.blank?
        @add_city.each_with_index do |city,index|
          self.transports.last.update_attributes(:end => city,:transport_mode => "", :transport_name => "Flights",:transfer_section => "not_included",:transfer_mode => "",:time_of_onward => [])
          self.transports.create(:start => city,:end => @cities.first)
        end
      end
    end
    unless @add_city.blank?
      @add_city.each_with_index do |city,index|
        self.transports.last.update_attributes(:end => city,:transport_mode => "", :transport_name => "",:transfer_section => "not_included",:transfer_mode => "",:time_of_onward => [])
        self.transports.create(:start => city,:end => @cities.first)
      end
    end
  end

  def in_city_transport(type)
    @cities = self.cities
    if type == 'create'
      manage_city_transports
    elsif @cities.order(:created_at).pluck(:city_name) == self.city_transports.order(:created_at).pluck(:city_name).reverse
      self.city_transports.destroy_all
      manage_city_transports
    else 
      @cities = @cities.order(:created_at).pluck(:city_name)
      @cities.delete_at(0) unless @cities.blank?
      @city_to_update = self.city_transports.order(:created_at).pluck(:city_name)
      @city_removes = @city_to_update - @cities
      @add_city = @cities - @city_to_update
      unless @city_removes.blank?
        @city_removes.each_with_index do |city,index|
          self.city_transports.where(:city_name => city).destroy_all
        end
      end
      unless @add_city.blank?
        @add_city.each_with_index do |city,index|
          self.city_transports.create(:city_id =>self.cities.find_by_city_name(city).id,:city_name => city)
        end
      end
    end
    unless @add_city.blank?
      @add_city.each_with_index do |city,index|
        self.city_transports.create(:city_id =>self.cities.find_by_city_name(city).id,:city_name => city)
      end
    end
  end

  def add_inclusion
    self.create_inclusion
  end

  def sight_secne(type)
    days = self.package_duration.split(" ")
    if type == 'create'
      days[2].to_i.times do 
        (self.sight_scenes.create)
      end
    else
      if days[2].to_i != self.sight_scenes.count
        self.sight_scenes.destroy_all
        days[2].to_i.times do 
          (self.sight_scenes.create)
        end
      end
    end
  end

  def create_itineraries(type)
    days = self.package_duration.split(" ")
    if type == 'create' 
      days[2].to_i.times do 
       (self.itineraries.create)
     end
   elsif days[2].to_i != self.self.itineraries.count
    self.itineraries.destroy_all
    days[2].to_i.times do 
      (self.itineraries.create)
    end
  end
end


def create_meall(type)
  type == 'create' ? true : self.meal.destroy
  self.create_meal
end

def self.search filter_query, ids
  if filter_query
    self.where("id IN (?) and itinerary_name ILIKE ? ", ids, "%#{filter_query}%")
  else
    self.all
  end
end  

  def self.search_by_ids ids
    # if ids.blank?
    self.where("id IN (?) ", ids)
    # else
    #   self.all
    # end
  end

  def self.search_by_start_date_and_duration ids, start_date, duration, order_by
    where("id IN (?) and start_date >= ? and package_duration ILIKE ?", ids, start_date.to_date, "%#{duration}%").order(order_by)
  end

  def self.search_by base_city, destination_city, start_date, duration, order_by
    ids= []
    packages = Package.all
    ids = packages.map{|x| x if x.cities.first.city_name.downcase == base_city.downcase}.compact.map(&:id)
    ids = packages.map{|x| x if (x.cities.first.city_name.downcase == base_city.downcase and x.cities.last.city_name.downcase == destination_city.downcase) }.compact.map(&:id) unless destination_city.empty?
    result = Package.search_by_start_date_and_duration(ids, start_date, duration, order_by)
    @ids = result.pluck(:id)
    # Package.search_by_ids(ids)
    result
  end

  # method to filter the packages against the all filter
  def self.filter_by holidays, holiday_types, included, rating, sort_by
    ids = @ids
    packages = search_by_ids(ids)
    arr = packages.map{|x| x}.flatten

    unless sort_by == "city_name"
      arr = arr.sort_by{ |a| a.send(sort_by)}
    else
      arr = arr.sort_by{ |a| a.cities.last.city_name}
    end
    arr.reject{ |a| a if (((a.holidays & holidays) != holidays) || (a.holiday_types & holiday_types != holiday_types) || (a.included & included != included) || (a.hotels.map(&:rating) & rating != rating) )}
  end

  def manage_transports
    @cities.each_with_index do |city,index|
      unless @cities.last.id == city.id
        self.transports.create(:start => @cities[index].city_name,:end => @cities[index+1].city_name)
      else
        self.transports.create(:start => @cities[index].city_name,:end => @cities.first.city_name)
      end
    end   
  end

  def manage_city_transports
    self.cities.each_with_index do |city,index|
      unless @cities.first.id == city.id
        self.city_transports.create(:city_id => city.id,:city_name => city.city_name )
      end
    end  
  end

  def self.owner_of package_id
    find_by_id(package_id).user
  end

end
