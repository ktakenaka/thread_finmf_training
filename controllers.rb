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
  if params['thread_name']
    thread_id = Thread2ch.create(params['user_name'], params['thread_name'])
    redirect "/#{thread_id}"
  else
    @alert = 'スレタイが空欄はダメ'
    redirect '/'
  end
end

post "/post" do
  post = Post.new(params['user_name'],params['content'],params['thread_id'])
  thread_id = post.thread_id
  post.save
  redirect "/#{thread_id}"
end
