get '/blog/:id' do
    @blog = Blogs.find params[:id].to_i
    @title = @blog.title
    erb :'blog/show'
end