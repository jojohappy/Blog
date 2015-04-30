class CreateBlogContents < ActiveRecord::Migration
	def up
		create_table :blog_contents do |t|
			t.text "content", :null => false, :limit => 65535 + 1
		end
	end

	def down
		drop_table :blog_contents
	end
end