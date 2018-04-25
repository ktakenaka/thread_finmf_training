class Top < Sinatra::Base
  get "/" do
    @title = "threads"
    @threads = Thread2ch.all
    erb :thread_list
  end
end
