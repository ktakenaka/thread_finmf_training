require 'sinatra'
require 'sinatra/reloader'
#require './models.rb'
require './model_thread.rb'
require './model_post.rb'

get "/" do
  @title = "threads"
  @threads = Thread2ch.all
  erb :thread_list
end

get "/:thread_id" do
  thread = Thread2ch.new(params[:thread_id])
  @thread_id = thread.id
  @thread_name = thread.name
  @posts = thread.posts
  erb :thread
end

post "/thread" do
  thread_id = Thread2ch.create(params['user_name'], params['thread_name'])
  #SQLにつくる、IDもらう、返す
  redirect "/#{thread_id}"
end

post "/post" do
  post = Post.new(params['user_name'],params['content'],params['thread_id'])
  thread_id = post.thread_id
  post.save
  redirect "/#{thread_id}"
end
