# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
   include CarrierWave::RMagick
   include CarrierWave::MiniMagick
   include Cloudinary::CarrierWave

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  version :logo do
    cloudinary_transformation :width => 80, :height => 30,:crop => :thumb
  end

  version :big_logo do
    cloudinary_transformation :width => 180, :height => 120,:crop => :thumb
  end

  version :itinerary do
    cloudinary_transformation :width => 115, :height => 85,:crop => :thumb
  end

end