class DropTags < ActiveRecord::Migration
	def up
		drop_table :tags
	end

	def down
		create_table :tags do |t|
			t.string "tag_name"
			t.datetime "create_datetime"
		end
	end
end