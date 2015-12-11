class Crm < ActiveRecord::Base

  belongs_to :package
  belongs_to :user


  FILTER_BY = ['Name','Destination', 'Start From']

  def self.search ids, filter_query, filter_against
  	if filter_query
  		self.where("package_id IN (?) and #{filter_against.downcase.tr(" ", "_")} LIKE ? ", ids, "%#{filter_query}%")
  	else
  		where("package_id IN (?)", ids).order("#{filter_against.downcase.tr(" ", "_")} asc")
  	end
  end

  def self.all_by_ids ids
    Crm.where(:id => ids)
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |crm|
        csv << crm.attributes.values_at(*column_names)
      end
    end
  end

  def self.update_status ids, mark_as
    where(:id => ids).update_all(:status => mark_as)
  end

  def self.delete_by_ids ids
    delete_all(:id => ids)
  end

  def self.create_and_sent_as_attach ids, email
    file_path = "#{Rails.root}/public/crms/csv_attached"
    FileUtils.mkdir_p(file_path) unless File.exists?(file_path)
    file_path = "#{file_path}/crms_#{rand(100..999)}.csv"
    
    csv_string = CSV.generate({}) do |csv| 
      csv << column_names
      if ids.blank?
        self.all.each do |e|
          csv << e.attributes.values_at(*column_names)
        end
      else
        where(:id => ids).each do |e|
          csv << e.attributes.values_at(*column_names)
        end
      end
    end
    File.open(file_path, "w"){ |f| f << csv_string }
    UserMailer.send_crms_with_attachment(email, file_path).deliver
    File.delete(file_path) if File.exist?(file_path)
  end

end
