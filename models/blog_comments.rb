class BlogComments < ActiveRecord::Base
    belongs_to :blogs

    validates :comment, :presence => true
    validates :username, :presence => true

    def md_content
        GitHub::Markup.render('comments', comment)
    end
end