class NewPost < Sinatra::Base
  post "/post" do
    post = Post.new(params['user_name'],params['content'],params['thread_id'])
    thread_id = post.thread_id
    post.save
    redirect "/#{thread_id}"
  end
end
