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
  attr_reader :name,:id
  def initialize(thread_id)
    client = build_connection
    @id   = thread_id
    @name = client.query("SELECT thread_name FROM threads WHERE id='#{@id}'").to_a.first['thread_name']
  end

  def posts
    client = build_connection
    client.query("SELECT * FROM posts WHERE thread_id='#{@id}'").to_a
  end

  def self.all
    client = build_connection
    client.query("SELECT * FROM threads").to_a
  end

  def self.create(user_name, thread_name)
    client = build_connection
    client.query("
      INSERT INTO threads (user_name, thread_name) VALUES ('#{user_name}', '#{thread_name}')"
    )
    client.query("SELECT id FROM threads WHERE thread_name='#{thread_name}'").to_a.first['id']
  end
end

class Post
  attr_reader :thread_id
  def initialize(user_name,content,thread_id)
    @user_name   = user_name
    @content     = content
    @thread_id   = thread_id.to_i
  end

  def save
    client = build_connection
    client.query(
      "INSERT INTO posts (user_name, content, thread_id) VALUES('#{@user_name}', '#{@content}','#{@thread_id}')"
    )
  end
end
