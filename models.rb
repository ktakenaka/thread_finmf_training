require 'mysql2'

class Threads
  class << self
    def read_list
      client = Mysql2::Client.new(:host => 'localhost', :user => 'root', :password => 'password')
      query = %q{select * bulleten_boards.threads}
      results = client.query(query)
    end

    def create_thread
      #すれIDにデータを挿入する
    end
  end
end


class Posts

  class << self
    def read_posts
      [{ name: 'take', created_at: 30000, content: 'あいうえお' }]
    end

    def create_post
    end
  end
end
