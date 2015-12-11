module SimilarPackagesAlgorithm
	def similar_packages(package)
		destination = package.cities.last.city_name.downcase; duration = package.package_duration.split(' ')[0].to_i
		price = package.price_per_person; holyday_type = package.holiday_types
		packages = Package.today_onwards - Array(package)

		similar_packages = []
		packages.each do |pack|
			package_hash = {}
			destination_points = 0; duration_points = 2.5; price_points = 0; holidays_points = 0

      # package destinatoin
      pack_destination = pack.cities.last.city_name.downcase
      destination_points = 4 if pack_destination == destination

      # package duration
      pack_duration = pack.package_duration.split(' ')[0].to_i
      case 
      when pack_duration == duration
          # initizer point
        when pack_duration < duration
        	duration_points -= duration-pack_duration
        when pack_duration > duration
        	duration_points -= pack_duration-duration
        end

      # package price
      case pack.price_per_person
      when ( price..(price + (price*5)/100) )
      	price_points = 2.0
      when ( price..(price + (price*15)/100) )
      	price_points = 1.5
      when ( price..(price + (price*25)/100) )
      	price_points = 1.0
      when ( price..(price + (price*35)/100) )
      	price_points = 0.5
      when ( price..(price + (price*50)/100) )
      	price_points = 0
      else
      	price_points = -1
      end

      # package holyday types
      holidays_points = package.holiday_types.map{|x| x.downcase}.sort.eql?(pack.holiday_types.map{|x| x.downcase}.sort) ? 1.5 : 0.5
      
      # total
      pack.similarity_score = destination_points + duration_points + price_points + holidays_points

      package_hash[:id] = pack.id
      package_hash[:name] = pack.itinerary_name
      package_hash[:duration] = pack.package_duration.split(' ').first(2).join(' ')
      package_hash[:price] = pack.price_per_person
      package_hash[:cover_picture] = pack.pictures.first.image.url(:rec_side)
      package_hash[:operator_logo] = pack.user.profile.logo.url(:logo)
      package_hash[:similarity_score] = pack.similarity_score

      similar_packages.push(package_hash)
    end
    similar_packages.sort_by{|x|x[:similarity_score]}.reverse
  end
end