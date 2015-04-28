class CreateBlogComments < ActiveRecord:Migration
	def up
		create table :blog_comments do |t|
			t.string "comment", :null => false
			t.string "username", :null => false
			t.string "email"
			t.datetime "create_datetime"
		end
		add_reference :blog_comments, :blogs, index: true
	end

	def down
		drop_table :blog_comments
	end
end
