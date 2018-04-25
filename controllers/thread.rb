class Threader < Sinatra::Base
  get "/:thread_id" do
    thread = Thread2ch.new(params[:thread_id])
    @thread_id = thread.id
    @thread_name = thread.name
    @posts = thread.posts
    erb :thread
  end
end
