get '/' do
    @blogs = Blogs.order('id Desc')
    erb :'home/index'
end

get '/about' do
	markdown = Redcarpet::Markdown.new(HTMLwithPygments, :fenced_code_blocks => true, :tables => true)
    @about = markdown.render(File.read(File.expand_path("./md") + '/about.md'))
	erb :'about'
end