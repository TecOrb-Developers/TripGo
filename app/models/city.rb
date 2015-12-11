class City < ActiveRecord::Base
   
   belongs_to :package
   has_many :city_transports, dependent: :destroy


	def self.packages_by_destination filter_query, packages_ids
		where("package_id IN (?) and city_name ILIKE ?", packages_ids, "%#{filter_query}%" ).order('package_id DESC').select(:package_id).distinct.pluck(:package_id)
	end

	def self.packages_ids_by city_name, order = 'ASC'
		Package.all.map{|x| x if x.cities.first.city_name.downcase == city_name.downcase}.compact.map(&:id)
	end

end
