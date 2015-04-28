class CreateBlogContents < ActiveRecord:Migeration
	def up
		create_table :blog_contents do |t|
			t.string "content", :null => false, :limit => 64.kilobytes + 1
		end
	end

	def down
		drop_table :blog_contents
	end
end