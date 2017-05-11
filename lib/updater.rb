require 'sinatra/base'
class Updater < Sinatra::Base
  # threaded - False: Will take requests on the reactor thread
  #            True:  Will queue request for background thread
  configure do
    set :port, 3000
    disable :logging
  end

  # Request runs on the reactor thread (with threaded set to false)
  get '/update' do
    if system("ps ax | grep rpush | grep -v grep | awk '{print \"kill -1 \" $1}' | sh")
      status 200
    else
      status 500
    end
  end

  run!
end
