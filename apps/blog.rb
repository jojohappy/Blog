get '/blog/:id' do
    @blog = Blogs.find params[:id].to_i
    @title = @blog.title
    erb :'blog/show'
end

post '/blog/:id/comments' do
    content_type 'text/javascript'
    blog = Blogs.find params[:id].to_i
    @comment = blog.blog_comments.create(:username => params['blog_comments']['username'], :comment => params['blog_comments']['comment'], :create_datetime => Time.now)
    erb :"create_comment.js", :layout => false
end

get '/comment/quote' do
    comment = BlogComments.find params[:id].to_i
    body = "\n> #{comment.username} 评论:\n\n"
    comment.comment.gsub(/\n{3,}/, "\n\n").split("\n").each {|line| body << "> #{line}\n\n"}
    body
end

get '/comment/preview' do
    data = params[:data]
    Common.render_markdown(data)
end