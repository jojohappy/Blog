require 'fileutils'
require 'tempfile'
require 'qiniu'

before '/admin/*' do
    if !account_login?
        redirect to('/login')
    end
end

get '/admin/blog/new_blog' do
    @blog = Blogs.new
    @title = ''
    erb :'admin/new_blog'
end

post '/admin/blog' do
    @blog = Blogs.new(params[:blogs])
    @blog.create_datetime = DateTime.now
    @title = @blog.title
    if @blog.save
        redirect to('/blog/' + @blog.id.to_s)
    else
        erb :'admin/new_blog'
    end
end

post '/admin/blog/upload_image' do
    content_type :json
    tempfile = params[:upload_file][:tempfile]
    local_file_name = SecureRandom.uuid + File.extname(params[:original_filename])
    local_file_path = settings.public_folder + '/images/upload/' + local_file_name
    FileUtils.cp tempfile.path(), local_file_path
    FileUtils.chmod 644, local_file_path
    {:success => 'true', :file_path => '/images/upload/' + local_file_name}.to_json
end

post '/admin/blog/preview' do
    data = CGI::unescapeHTML(params[:data].to_s.strip)
    data = data.gsub(/<p>/, '').gsub(/<\/p>/, '<br>')
    data = data.gsub(/<br>/, "\n")
    Common.render_markdown(data)
end

post '/admin/blog/:id' do
    @blog = Blogs.find params[:id].to_i
    @title = @blog.title
    if @blog.update_blog(params[:blogs])
      redirect to('/blog/' + @blog.id.to_s)
    else
      ert :'admin/edit'
    end
end

delete '/admin/blog/:id' do
    @blog = Blogs.find params[:id].to_i
    @blog.destroy
end

get '/admin/blog/:id/edit' do
    @blog = Blogs.find params[:id].to_i
    @title = @blog.title
    erb :'admin/edit'
end

get '/admin/gallery/new_gallery' do
    @gallery = Gallerys.new
    erb :'admin/new_gallery', :layout => :layout_gallery
end

get '/admin/gallery/uptoken' do
    put_policy = Qiniu::Auth::PutPolicy.new(
        settings.qiniu_config['bucket']
    )
    uptoken = Qiniu::Auth.generate_uptoken(put_policy)
    {:uptoken => uptoken}.to_json
end

delete '/admin/gallery/gallerys/:key' do
    key = params[:key].to_s
    if params[:type].to_i == 1
        code, result, response_headers = delete_remote_gallery(key)
        {:code => code.inspect, :result => result.inspect}.to_json
    else
        {:code => 202, :result => '{}'}.to_json
    end
end

post '/admin/gallery' do
    @gallery = Gallerys.new(params[:gallerys])
    @gallery.create_datetime = DateTime.now
    @title = @gallery.title
    if @gallery.save
        redirect to('/gallery/' + @gallery.id.to_s)
    else
        erb :'admin/new_gallery', :layout => :layout_gallery
    end
end

post '/admin/gallery/:id' do
    @gallery = Gallerys.find params[:id].to_i
    @title = @gallery.title
    if @gallery.update_gallery(params[:gallerys])
      redirect to('/gallery/' + @gallery.id.to_s)
    else
      erb :'admin/edit_gallery', :layout => :layout_gallery
    end
end

delete '/admin/gallery/:id' do
    @gallery = Gallerys.find params[:id].to_i
    @gallery.destroy
end

get '/admin/gallery/:id/edit' do
    @gallery = Gallerys.find params[:id].to_i
    @title = @gallery.title
    erb :'admin/edit_gallery', :layout => :layout_gallery
end