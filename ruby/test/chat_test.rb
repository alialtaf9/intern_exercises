require 'minitest/autorun'
require 'minitest/reporters'
require 'httparty'
require 'json'

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

def api_base_address
  "http://localhost:3000"
end

def example_message_query(user_name='Siimar Sapikas', message='Good morning')
  {
    body: {
      'message[user_name]' => user_name,
      'message[text]' => message
    }
  }
end

def example_user_query_data(user_name='Siimar Sapikas')
  {
    body: {
      'user[name]' => user_name
    }
  }
end

describe 'Chat REST API' do
  describe "creating new user" do
    it "POST /users creates new user" do
      unique_user_name = "Vello Orumets #{Random.rand(10**6)}"
      response = HTTParty.post "#{api_base_address}/users", example_user_query_data(unique_user_name)
      response.code.must_equal 201
      JSON.parse(response.body)['name'].must_equal unique_user_name
    end

    it "POST /users twice with same name fails" do
      HTTParty.post "#{api_base_address}/users", example_user_query_data
      response = HTTParty.post "#{api_base_address}/users", example_user_query_data
      response.code.must_equal 422
    end
  end

  describe 'sending messages to chat' do
    it 'successfully receives message when name and message are present' do
      skip 'Not implemented'
    end

    it 'fails when message is sent without username' do
      response = HTTParty.post "#{api_base_address}/messages", example_message_query
      response.code.must_equal 200
    end
    
    it 'fails with empty message' do
      skip 'Not implemented'
    end
  end
end
