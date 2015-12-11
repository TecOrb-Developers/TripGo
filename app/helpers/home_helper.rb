module HomeHelper
	# not in use.. :D moved to controller :P
	def wishlist_packages
		unless current_user
			ids = cookies[:wishlist_bucket] ? cookies[:wishlist_bucket].split(',') : []
		else
			# loged in
			temp_ids = cookies[:wishlist_bucket] ? cookies[:wishlist_bucket].split(',') : []
			ids = current_user.wishlist.nil? ? [] : current_user.wishlist.package_ids.split(',')
			ids = (ids+temp_ids).uniq
		end
		Package.where(id: ids)
	end

	def list_count
		list_count = {}
		list_count[:wishlist] = current_user ? current_user.wishlists.count : 0
		list_count[:compare_list] = current_user ? current_user.packages_for_compare.count : 0
		list_count
	end

	def is_enquired?(package)
		current_user.enquiries.pluck(:package_id).include?(package.id) ? 'in-wishlist' : ''
	end

end
