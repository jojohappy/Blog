get '/' do
    @blogs = Blogs.order('id Desc')
    erb :'home/index'
end
