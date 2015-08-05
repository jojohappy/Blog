helpers do
    def create_time_to_word(t)
        create_datetime = DateTime.strptime(t, '%Y-%m-%d %H:%M:%S %z')
        create_datetime.strftime('%^B %d, %Y')
    end

    def my_escape_javascript(html_content)
      return '' unless html_content
      javascript_mapping = { '\\' => '\\\\', '</' => '<\/', "\r\n" => '\n', "\n" => '\n' }
      javascript_mapping.merge("\r" => '\n')
      escaped_string = html_content.gsub(/(\\|<\/|\r\n|[\n\r])/) { javascript_mapping[$1] }
      "#{escaped_string}"
    end

    def tag_cloud
      tag_body = ''
      tags = ActsAsTaggableOn::Tag.all
      tags.each do |tag|
        tag_body << '<a class="blog-edit-tag a-tag-tags" name="' + tag.name + '"><i class="fa fa-tags"></i>' + tag.name + '</a>'
      end
      return tag_body
    end
end