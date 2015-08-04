# encoding: utf-8
class Blogs < ActiveRecord::Base
    acts_as_taggable

    belongs_to :blog_contents, :dependent => :destroy
    has_many :blog_comments, :class_name => 'BlogComments', :dependent => :destroy

    validates :title, :presence => true
    validates :title, :length => {:in => 1..100}
    validates :md_file_url, :presence => true

    delegate :content, :to => :blog_contents, :allow_nil => true

    def md_content
        markdown = Redcarpet::Markdown.new(HTMLwithPygments, :fenced_code_blocks => true, :tables => true)
        markdown.render(File.read(File.expand_path("./md") + '/' + md_file_url))
    end

    def content=(value)
        self.blog_contents ||= BlogContents.new
        self.blog_contents.content = value
    end

    def md_file_content
        body = ''
        file = File.read(File.expand_path("./md") + '/' + md_file_url).to_s
        file.gsub(/\n{3,}/, "\n\n").split("\n").each {|line| body << "#{line}<br>"}
        body
    end
end