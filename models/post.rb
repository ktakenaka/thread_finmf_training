require_relative 'db'

class Post
  MIN_SIZE = 3
  MAX_SIZE = 100
  attr_reader :id,:user_name,:content,:created_at,:thread_id
  def initialize(id: nil, user_name: nil, content: nil, created_at: nil, thread_id: nil)
    @id          = id
    @user_name   = user_name || 'nobody'
    @content     = content
    @created_at  = created_at
    @thread_id   = thread_id.to_i
  end

  def save
    DB.query(
      "INSERT INTO posts (user_name, content, thread_id) VALUES('#{@user_name}', '#{@content}','#{@thread_id}')"
    )
  end

  def validate
    unless @content.size <= MIN_SIZE && @content.size >= MAX_SIZE
      #raise Invalid, '長さ！'
    end
  end
end
