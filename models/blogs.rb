# encoding: utf-8
class Blogs < ActiveRecord::Base
    acts_as_taggable

    belongs_to :blog_contents, :dependent => :destroy
    has_many :blog_comments, :class_name => 'BlogComments', :dependent => :destroy

    validates :title, :presence => true
    validates :title, :length => {:in => 1..100}
    validates :md_file_url, :presence => true

    delegate :content, :to => :blog_contents, :allow_nil => true

    after_destroy :rm_md_file

    def md_content
        Common.render_markdown(File.read(File.expand_path("./md") + '/' + md_file_url))
    end

    def content=(value)
        self.blog_contents ||= BlogContents.new
        value = CGI::unescapeHTML(value)
        value = value.gsub(/<p>/, '').gsub(/<\/p>/, '<br>').gsub(/<br>/, "\n").gsub(/&nbsp;/, ' ')
        md_value = Common.render_markdown(value)
        self.blog_contents.content = md_value.truncate(300)
        if nil == self.md_file_url or '' == self.md_file_url
            self.md_file_url = SecureRandom.uuid + '.md'
        end
        File.open(File.expand_path("./md") + '/' + self.md_file_url, 'w') { |file| file.write(value)}
    end

    def md_file_content
        body = ''
        begin
            file = File.read(File.expand_path("./md") + '/' + md_file_url).to_s
            file.gsub(/\n{3,}/, "\n\n").split("\n").each {|line| body << "#{line}<br>"}
        rescue TypeError
            body
        end
        body
    end

    def update_blog(param_hash)
        self.transaction do
            update_attributes!(param_hash)
            blog_contents.save!
            save!
        end
    rescue
        return false
    end

    def rm_md_file
        File.delete(File.expand_path("./md") + '/' + md_file_url)
    end
end
