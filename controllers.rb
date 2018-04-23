require 'sinatra'
require 'sinatra/reloader'
require './models.rb'

get "/" do
  @title = "threads"
  @threads = [
    { created_at: 18, title: 'trial', user_name: 'take' }
  ]
  erb :thread_list
end

get "/:thread_name" do
  @thread_name = params[:thread_name]
  @posts = [
    { name: 'take', created_at: 30000, content: 'あいうえお' }
  ]

  erb :thread
end

post "/new" do
  #create new thread
  #redirect /thread
end

post "/:thread_name/new/?:reply_to" do
  #create new post
  #redirect "/:thread"
end
