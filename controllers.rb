require 'sinatra'
require 'sinatra/reloader'
require_relative './models/thread.rb'
require_relative './models/post.rb'

get "/" do
  @page_title = "threads"
  @threads = Thread2ch.all
  erb :thread_list
end

get "/:thread_id" do
  thread = Thread2ch.new(id: params[:thread_id])
  @thread_id = thread.id
  @thread_name = thread.thread_name
  @posts = thread.posts
  erb :thread
end

post "/thread" do
  user_name ||= 'nobody'
  new_thread = Thread2ch.new(
    thread_name: params['thread_name'],
    user_name:   user_name
  )
  new_thread.save
  redirect "/"
end

post "/post" do
  user_name ||= 'nobody'
  post = Post.new(
    user_name: user_name,
    content:   params['content'],
    thread_id: params['thread_id']
  )
  post.validate
  post.save
  redirect back
end
