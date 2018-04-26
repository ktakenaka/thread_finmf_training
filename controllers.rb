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
  thread = Thread2ch.find(params[:thread_id])
  @posts = thread.posts
  @thread_id = thread.id
  @thread_name = thread.thread_name
  erb :thread
end

post "/thread" do
  params['user_name'] = params['user_name'].gsub!(/ /, '')
  new_thread = Thread2ch.new(
    thread_name: params['thread_name'],
    user_name:   params['user_name']
  )
  new_thread.save
  redirect "/"
end

post "/post" do
  if params['content'].gsub!(/ /,'')
    params['user_name'] = params['user_name'].gsub!(/ /, '')
    post = Post.new(
      user_name: params['user_name'],
      content:   params['content'],
      thread_id: params['thread_id']
    )
    post.save
  end
  redirect back
end
