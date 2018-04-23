require 'sinatra'
require 'sinatra/reloader'
require './models.rb'

get "/" do
  @title = "threads"
  @threads = Threads.read_list
  erb :thread_list
end

get "/:thread_name" do
  @thread_name = params[:thread_name]
  @posts = Posts

  erb :thread
end

post "/new_thread" do
  #create new thread
  #redirect /thread
  redirect erb :thread
end

post "/:thread_name/new/?:reply_to" do
  #create new post
  #redirect "/:thread"
end
