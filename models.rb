require 'mysql2'
require 'sinatra/reloader'


class Threads
  def initialize
    @client = Mysql2::Client.new(
      :username => 'root',
      :password => 'Pl0st1541',
      :host => 'localhost'
    )
  end

  def read_list
    @client.query(
      'SELECT * FROM bulletin_board.threads'
    )
  end

  def create_thread(user_name, thread_name)
    @client.query(
      "INSERT INTO bulletin_board.threads (user_name, thread_name) VALUES('#{user_name}', '#{thread_name}')"
    )
  end
end


class Posts
  def initialize
    @client = Mysql2::Client.new(
      :username => 'root',
      :password => 'Pl0st1541',
      :host => 'localhost'
    )
  end

  def read_posts(thread_name)
    thread_instance = @client.query(
      "SELECT id FROM bulletin_board.threads WHERE thread_name = '#{thread_name}'"
    )
    thread_id = thread_instance.map { |n| n }[0]['id']
    @client.query(
      "SELECT * FROM bulletin_board.posts WHERE thread_id = '#{thread_id}'",
    )
  end

  def create_post(user_name,post_content,thread_name)
    thread_instance = @client.query(
      "SELECT id FROM bulletin_board.threads WHERE thread_name = '#{thread_name}'"
    )
    thread_id = thread_instance.map { |n| n }[0]['id']
    @client.query(
      "INSERT INTO bulletin_board.posts (user_name, content, thread_id) VALUES('#{user_name}', '#{post_content}','#{thread_id}')"
    )
  end
end
