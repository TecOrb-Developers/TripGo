# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # different versions of your uploaded files:
  version :rec_side do
    cloudinary_transformation :width => 243, :height => 100,:crop => :thumb
  end

  version :rec_center do
    cloudinary_transformation :width => 900, :height => 530,:crop => :thumb
  end

  version :weekend do
    cloudinary_transformation :width => 275, :height => 245,:crop => :thumb
  end

#Inclusion page
  version :package_main_icon do
    cloudinary_transformation :width => 45, :height => 33,:crop => :thumb
  end
  version :package_inclusion do
    cloudinary_transformation :width => 189, :height => 142,:crop => :thumb
  end
  version :package_icon do
    cloudinary_transformation :width => 115, :height => 85,:crop => :thumb
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end


end