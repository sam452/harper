require 'rubygems'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'slim'

class UberUrlShortener < Sinatra::Base
  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  enable :inline_templates

  assets do
  	serve '/js', from: 'app/js'
  	serve '/css', from: 'app/css'
    serve '/image', from: 'app/image'
  end

  css :cssapp, [
  	'/css/*.css'
  ]

  js :jsapp, [
  	'/js/*.js'
  ]

  css_compression :simple
  js_compression :jsmin

end

class Harper < Sinatra::Base
get '/contact' do
	erb :contact
end


run! if app_file == $0
end

