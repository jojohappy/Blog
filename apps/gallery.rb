get '/gallery' do
    @gallerys = Gallerys.order('id Desc')
    erb :'gallery/index', :layout => :layout_gallery
end

post '/gallery/:id/ripple' do
    gallery = Gallerys.find params[:id].to_i
    gallery.ripple += 1
    gallery.save
    gallery.ripple.to_s
end

get '/gallery/:id' do
    @gallery = Gallerys.find params[:id].to_i
    @title = @gallery.title
    erb :'gallery/gallery', :layout => :layout_gallery
end

