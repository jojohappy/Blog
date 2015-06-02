class BlogContents < ActiveRecord::Base
    validates :content, :presence => false
end