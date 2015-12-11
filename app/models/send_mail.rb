class Send_mail < ActiveRecord::Base

  def self.columns 
    @columns ||= []
  end

end