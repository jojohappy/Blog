class CreateGallerys < ActiveRecord::Migration
    def up
        create_table :gallerys do |t|
            t.string "title", :limit => 255, :null => false
            t.datetime "create_datetime", :null => false
            t.datetime "update_datetime"
            t.string "cover", :null => false
            t.integer "ripple", :default => 0
        end
    end

    def down
        drop_table :gallerys
    end
end
