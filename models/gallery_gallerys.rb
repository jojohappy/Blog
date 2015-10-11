# encoding: utf-8
class GalleryGallerys < ActiveRecord::Base
	belongs_to :gallerys

	after_destroy :delete_remote_gallerys

	def delete_remote_gallerys
		delete_remote_gallery(key)
	end
end