class ChangeBlogCommentsType < ActiveRecord::Migration
  def self.up
    change_column :blog_comments, :comment, :text, limit: 65535 + 1, null: false
  end

  def self.down
    change_column :blog_comments, :comment, :string, null: false
  end
end