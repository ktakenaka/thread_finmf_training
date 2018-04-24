require 'sinatra'
require 'sinatra/reloader'
require './models.rb'

get "/" do
  @title = "threads"
  threads = Threads.new
  @threads = threads.read_list
  erb :thread_list
end

get "/:thread_name" do
  @thread_name = params[:thread_name]
  posts = Posts.new
  @posts = posts.read_posts(@thread_name)
  if @posts
    erb :thread
  else
    redirect '/'
  end
end

#post /threadでいいやん
post "/thread" do
  @name = params['user_name']
  @thread_name = params['thread_name']
  threads = Threads.new
  threads.create_thread(@name,@thread_name)
  redirect "/#{@thread_name}"
end

post "/post" do
  @name = params['user_name']
  @post = params['post']
  @thread_name = params['thread_name']
  post = Posts.new
  post.create_post(@name, @post, @thread_name)
  redirect "/#{@thread_name}"
end
