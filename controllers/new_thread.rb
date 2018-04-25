class NewThread < Sinatra::Base
  post "/thread" do
    thread_id = Thread2ch.create(params['user_name'], params['thread_name'])
    redirect "/#{thread_id}"
  end
end
