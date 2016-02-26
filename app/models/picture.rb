class Picture < ActiveRecord::Base
	attr_accessor :image

	belongs_to :post
	mount_uploader :image, ImageUploader
end
