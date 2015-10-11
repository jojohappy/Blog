class DropBlogComments < ActiveRecord::Migration
    def up
        drop_table :blog_comments
    end

    def down
        create_table :blog_comments do |t|
            t.string "comment", :null => false
            t.string "username", :null => false
            t.string "email"
            t.datetime "create_datetime"
        end
        add_reference :blog_comments, :blogs, index: true
    end
end