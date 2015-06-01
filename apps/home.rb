get '/' do
    @blogs = [{title: "title1"},{title: "title2"},{title: "title3"}]
    erb :index
end
