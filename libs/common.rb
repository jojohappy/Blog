class Common
    def self.render_markdown(data)
        markdown = Redcarpet::Markdown.new(HTMLwithPygments, :fenced_code_blocks => true, :tables => true)
        return markdown.render(data)
    end
end

def delete_remote_gallery(key)
    bucket = MichaelDaiSite.settings.qiniu_config['bucket']
    return Qiniu::Storage.delete(bucket, key)
end