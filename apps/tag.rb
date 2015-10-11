get '/tags/:tag' do
    @blog_tags = {}
    tag_name = params[:tag]
    blogs = Blogs.tagged_with(params[:tag]).order('id DESC')
    @blog_tags[tag_name] = blogs
    erb :'tag/tag'
end

get '/tags' do
    @blog_tags = {}
    tags = ActsAsTaggableOn::Tag.all
    tags.each do |tag|
        blogs = Blogs.tagged_with(tag.name).order('id DESC')
        @blog_tags[tag.name] = blogs
    end
    erb :'tag/tag'
end