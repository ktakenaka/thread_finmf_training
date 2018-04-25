require 'mysql2'
require 'sinatra/reloader'

module ConnectToDB
  def build_connection
    Mysql2::Client.new(
      :database => 'bulletin_board',
      :username => 'root',
      :password => 'Pl0st1541',
      :host     => 'localhost'
    )
  end
end
