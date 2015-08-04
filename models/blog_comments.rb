class BlogComments < ActiveRecord::Base
    belongs_to :blogs

    validates :comment, :presence => true
    validates :username, :presence => true

    def md_content
        markdown = Redcarpet::Markdown.new(HTMLwithPygments, :fenced_code_blocks => true, :tables => true)
        markdown.render(self.comment)
    end
end