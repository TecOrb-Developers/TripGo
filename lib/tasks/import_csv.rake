require 'csv'
require 'open-uri'
require 'rubyXL'    


desc "Import CSV file into database"

	task :create_states_cities_of_india => :environment do
		StateCity.destroy_all
		workbook = RubyXL::Parser.parse("public/india_city/city.xlsx")
		worksheet = workbook['ct'].get_table[:table] # can use an index or worksheet name
		worksheet.each do |row|
			split_row = row['state_city'].to_s.split(',')
			state = split_row[0]
			city = split_row[1]
		   @state_city = StateCity.new(:state => state, :city => city)
          @state_city.save
		end unless worksheet.empty?
		puts "===================================================="
	end
    

