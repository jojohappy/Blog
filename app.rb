require 'sinatra/base'

class MichaelsBlog < Sinatra::Base
	get '/' do
		'Hello world!'
	end
end