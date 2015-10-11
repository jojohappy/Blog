# encoding: utf-8
class Gallerys < ActiveRecord::Base

    validates :title, :presence => true
    validates :title, :length => {:in => 1..255}
    validates :cover, :presence => true

    has_many :gallery_gallerys, -> { order "orders ASC" }, :dependent => :destroy, :class_name => 'GalleryGallerys'

    after_destroy :delete_remote_cover

    def gallerys=(value)
        if self.gallery_gallerys.empty?
            value.each {|v|
                @gallery = GalleryGallerys.new(v)
                self.gallery_gallerys << @gallery
            }
        else
            deleteGallerys = Array.new
            self.gallery_gallerys.map do |g|
                ary = value.select {|v|
                    v['key'] == g.key
                }
                if ary.count == 0
                    deleteGallerys << g.key
                end
            end
            deleteGallerys.each { |g|
                @gallery = self.gallery_gallerys.where(key: g).first
                self.gallery_gallerys.destroy(@gallery)
            }
            value.each { |v|
                key = v['key']
                r = self.gallery_gallerys.where(key: key).first
                if nil == r
                    @gallery = GalleryGallerys.new(v)
                    self.gallery_gallerys << @gallery
                end
            }
        end
    end

    def update_gallery(param_hash)
        self.transaction do
            if cover != param_hash[:cover]
                delete_remote_gallery(cover)
            end
            update_attributes!(param_hash)
            save!
        end
    rescue Exception => e
        p e.message
        p e.backtrace.inspect
        return false
    end

    def delete_remote_cover
        delete_remote_gallery(self.cover)
    end
end