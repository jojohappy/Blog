class RemoveTagsListToBlogs < ActiveRecord::Migration
	def up
		remove_column :blogs, :tag_list
	end

	def down
		add_column :blogs, :tag_list, :string
	end
end