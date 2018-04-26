require 'mysql2'

class DB
  def self.query(sql)
    client.query(sql, symbolize_keys: true)
  end

  private
    def self.client
      @client ||= Mysql2::Client.new(
        :database => '1ch',
        :username => 'root',
        :password => 'Pl0st1541',
        :host     => 'localhost'
      )
    end
end
