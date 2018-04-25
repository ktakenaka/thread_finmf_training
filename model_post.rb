require 'mysql2'
require 'sinatra/reloader'
require './module.rb'

class Post
  attr_reader :thread_id
  include ConnectToDB
  extend ConnectToDB
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
