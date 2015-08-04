get '/archives' do
	@blogs = Blogs.order('id Desc')
	erb :'archive/archive'
end