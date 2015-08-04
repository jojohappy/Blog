post '/admin/blog/:id' do
    params[:id]
end

get '/admin/blog/:id/edit' do
    @blog = Blogs.find params[:id].to_i
    @title = @blog.title
    erb :'blog/edit'
end

get '/admin/blog/preview' do
    data = params[:data].to_s.strip
    data = data.gsub(/<p>/, '').gsub(/<\/p>/, '<br>')
    data = data.gsub(/<br>/, "\n")
    markdown = Redcarpet::Markdown.new(HTMLwithPygments, :fenced_code_blocks => true, :tables => true)
    markdown.render(data)
end