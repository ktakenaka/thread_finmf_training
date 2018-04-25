require 'sinatra'
require 'sinatra/reloader'
require './models.rb'

get "/" do
  @title = "threads"
  @threads = Thread2ch.all
  erb :thread_list
end

get "/:thread_name" do
  @thread_name = params[:thread_name]
  @posts = Post.all(@thread_name)
  erb :thread
end

post "/thread" do
  thread = Thread2ch.new(params['user_name'], params['thread_name'])
  thread.save
  redirect "/#{thread.thread_name}"
end

post "/post" do
  post = Post.new(params['user_name'],params['content'],params['thread_name'])
  @thread_name = post.thread_name
  post.save
  redirect "/#{@thread_name}"
end
