require_relative 'db'

class Thread2ch
  attr_reader :id, :thread_name, :user_name, :created_at
  def initialize(id: nil, thread_name: 'no title', user_name: nil, created_at: nil)
    @id          = id
    @thread_name = thread_name
    @user_name   = user_name || 'nobody'
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

  def self.find(id)
    info_hash = DB.query("SELECT * FROM threads WHERE id='#{id}'").first
    new(info_hash)
  end
end
