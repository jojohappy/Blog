def get_all_content()
    @blogs = Blogs.order('id Desc')
    @blog_tags = {}
    tags = ActsAsTaggableOn::Tag.all
    tags.each do |tag|
        blogs = Blogs.tagged_with(tag.name).order('id DESC')
        @blog_tags[tag.name] = blogs
    end
end

before /^\/((?!admin|gallery))/ do
    get_all_content
end

get '/' do
    erb :'home/index'
end

get '/about' do
    @about = Common.render_markdown(File.read(File.expand_path("./md") + '/about.md'))
    erb :'about'
end

get '/login' do
    @account = Accounts.new
    erb :'home/login', :layout => false
end

post '/login' do
    @account = Accounts.new(params[:accounts])
    if login_account = Accounts.authenticate(@account.name, @account.password)
        session[:account_id] = login_account.id
        redirect to('/')
    else
        erb :'home/login', :layout => false
    end
end

delete '/logout' do
    if account_login?
        session[:account_id] = nil
    end
end