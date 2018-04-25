require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require './model_thread.rb'
require './model_post.rb'

require './controllers/top'
require './controllers/thread'
require './controllers/new_thread'
require './controllers/new_post'

class Application < Sinatra::Base
  use Top
  use Threader
  use NewThread
  use NewPost
end

run Application
