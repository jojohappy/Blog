class Common
  def self.render_markdown(data)
    markdown = Redcarpet::Markdown.new(HTMLwithPygments, :fenced_code_blocks => true, :tables => true)
    return markdown.render(data)
  end
end