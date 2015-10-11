class CreateGalleryGallerys < ActiveRecord::Migration
    def up
        create_table :gallery_gallerys do |t|
            t.string "url"
            t.string "key"
            t.integer "orders", :default => 0
        end
        add_reference :gallery_gallerys, :gallerys, index: true
    end

    def down
        drop_table :gallery_gallerys
    end
end
