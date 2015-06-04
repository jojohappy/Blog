# encoding: utf-8
class Blogs < ActiveRecord::Base
    belongs_to :blog_contents, :dependent => :destroy
    has_many :blog_comments, :class_name => 'BlogComments', :dependent => :destroy

    validates :title, :presence => true
    validates :title, :length => {:in => 3..100}
    validates :md_file_url, :presence => true

    delegate :content, :to => :blog_contents, :allow_nil => true

    def md_content
        GitHub::Markup.render(md_file_url, File.read(File.expand_path("./md") + '/' + md_file_url, :encoding => 'utf-8')).to_s
    end

end