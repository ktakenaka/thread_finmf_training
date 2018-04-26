require_relative 'application_entity'

class Thread2ch < ApplicationEntity
  attr_reader :id, :thread_name, :user_name, :created_at
  def initialize(id: nil, thread_name: 'no title', user_name: 'nobody', created_at: nil)
    @id          = id
    @thread_name = thread_name
    @user_name   = user_name
    @created_at  = created_at
  end

  def save
    DB.query("
      INSERT INTO threads (user_name, thread_name) VALUES ('#{user_name}', '#{thread_name}')"
    )
  end

  def posts
    DB.query("SELECT * FROM posts WHERE thread_id='#{@id}'")
  end

  def self.all
    DB.query("SELECT * FROM threads ORDER BY created_at DESC")
  end
end
