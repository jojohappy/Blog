class CreateTags < ActiveRecord:Migeration
	def up
		create_table :tags do |t|
			t.string "tag_name"
			t.datetiem "create_datetime"
		end
	end

	def down
		drop_table :tags
	end
end
