require 'mysql2'
require 'sinatra/reloader'

#クラスメソッドではinitializeが呼び出されず、継承が使えないし、moduleもextendとinclude両方必要で死んだ
def build_connection
  Mysql2::Client.new(
    :database => 'bulletin_board',
    :username => 'root',
    :password => 'Pl0st1541',
    :host     => 'localhost'
  )
end

class Thread2ch
  attr_reader :thread_name
  def initialize(user_name, thread_name)
    @user_name   = user_name
    @thread_name = thread_name
  end

  def save
    @client = build_connection
    @client.query(
      "INSERT INTO threads (user_name, thread_name) VALUES('#{@user_name}', '#{@thread_name}')"
    )
  end

  def self.all
    @client = build_connection
    @client.query("SELECT * FROM threads")
  end
end

class Post
  attr_reader :thread_name
  def initialize(user_name,content,thread_name)
    @user_name   = user_name
    @content     = content
    @thread_name = thread_name
  end

  def save
    @client = build_connection
    thread_instance = @client.query(
      "SELECT id FROM threads WHERE thread_name = '#{@thread_name}'"
    )
    thread_id = thread_instance.to_a.first['id']
    @client.query(
      "INSERT INTO posts (user_name, content, thread_id) VALUES('#{@user_name}', '#{@content}','#{thread_id}')"
    )
  end

  def self.all(thread_name)
    @client = build_connection
    thread_instance = @client.query(
      "SELECT id FROM threads WHERE thread_name = '#{thread_name}'"
    )
    thread_id = thread_instance.to_a.first['id']
    @client.query(
      "SELECT * FROM posts WHERE thread_id = '#{thread_id}'",
    ).to_a
  end
end
