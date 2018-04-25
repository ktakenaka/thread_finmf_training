require 'mysql2'
require 'sinatra/reloader'
require './module.rb'

class Thread2ch
  attr_reader :name,:id
  include ConnectToDB
  extend ConnectToDB
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
    client.query("SELECT * FROM threads ORDER BY updated_at DESC").to_a
  end

  def self.create(user_name, thread_name)
    client = build_connection
    client.query("
      INSERT INTO threads (user_name, thread_name) VALUES ('#{user_name}', '#{thread_name}')"
    )
    client.query("SELECT id FROM threads WHERE thread_name='#{thread_name}'").to_a.first['id']
  end
end
