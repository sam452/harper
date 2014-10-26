require 'rubygems'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'slim'
require 'json'
require 'net/http'
require 'pony'


class Harper < Sinatra::Base
  set :root, File.dirname(__FILE__)

  register Sinatra::AssetPack

  enable :inline_templates

  assets do
  	serve '/js', from: 'app/js'
  	serve '/css', from: 'app/css'
    serve '/image', from: 'app/image'
	  css :cssapp, [
	  	'/css/*.css'
	  ]

	  js :jsapp, [
	  	'/js/*.js'
	  ]

	  css_compression :simple
	  js_compression :jsmin
  end

  get '/' do
    slim :index
  end

 get '/contact' do
   
   slim :contact
 end

 post '/contact' do
   res = Net::HTTP.post_form(
     URI.parse('http://www.google.com/recaptcha/api/verify'),
       {
        'privatekey' => ENV['GOOGLE_RECAPTCHA_PK'],
        'remoteip' => request.ip,
        'challenge' => params[:recaptcha_challenge_field],
        'response' => params[:recaptcha_response_field]
       }
    )
   success, error_key = res.body.lines.map(&:chomp)
  puts params
  if success == 'true'
     Pony.mail(
       from: params[:name] + "<" + params[:email] + ">",
       to: 'sam@powerhat.org',
       subject: params[:name] + " has contacted you",
       body: params[:message],
      via: :smtp,
       via_options: {
        address:  'smtp.gmail.com',
        port:  '587',
        enable_starttle_auto: true,
        user_name: ENV['GMAIL_USERNAME'],
        password: ENV['GMAIL_PASSWORD'],
        authentication: :plain,
        domain: 'powerhat.org'
       }
      )
     redirect '/', notice: "Thanks for submitting"   
     else
      redirect '/', error: "Something went wrong. Try again"
    end
  end


	run! if app_file == $0

end

#class Harper < Sinatra::Base
#  get '/' do
#    slim :index
#  end
#end




