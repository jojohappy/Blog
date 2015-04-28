class CreateBlogs < ActiveRecord::Migration
    def up
        create_table :blogs do |t|
            t.string "title", :limit => 255, :null => false
            t.datetime "create_datetime", :null => false
            t.datetime "update_datetime"
            t.string "md_file_url", :null => false
            t.string "tag_list"
            t.integer "comment_count", :null => false, :default => 0
            t.timestamp
        end
        add_reference :blogs, :blog_contents, index: true
    end

    def down
        drop_table :blogs
    end
end
