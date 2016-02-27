# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :aws
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # process :sepiafy   => 0.8
  # process :raisefy   => [10,10,true]
  # process :blurify   => 0.50
  # process :flop
  # process :oil_paint => 6
  # process :frame
  # process :shearify  => [10.0,5.0]


  def sepiafy(percentage)
    manipulate! do |img|
      img.sepiatone(Magick::QuantumRange * percentage)
    end
  end

  def raisefy(a,b,c)
    manipulate! do |img|
      img.raise(a,b,c)
    end
  end

  def blurify(amount)
    manipulate! do |img|
      img.radial_blur(amount)
    end
  end

  def flop
    manipulate! do |img|
      img.flop
    end
  end

  def oil_paint(amount)
    manipulate! do |img|
      img.oil_paint(amount)
    end
  end

  def frame
    manipulate! do |img|
      img.frame
    end
  end

  def shearify(x,y)
    manipulate! do |img|
      img.shear(x,y)
    end
  end


  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  version :medium do
    process :resize_to_fit => [300, 200]
  end

  version :large do
    process :resize_to_fit => [800, 600]
  end



  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end