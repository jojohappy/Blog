require 'fileutils'
require 'tempfile'

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

get '/admin/blog/preview' do
    data = params[:data].to_s.strip
    data = data.gsub(/<p>/, '').gsub(/<\/p>/, '<br>')
    data = data.gsub(/<br>/, "\n")
    Common.render_markdown(data)
end