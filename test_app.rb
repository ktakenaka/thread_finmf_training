require './controllers.rb'
require './models.rb'
require 'minitest/autorun'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

class Controllers_test < MiniTest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_display_threads_list_when_open
    get '/'
    assert last_response.ok?
    assert_equal 'bar', response.body
  end

  def test_
end
