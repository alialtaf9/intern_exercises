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
      'user_name' => user_name,
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

def unique_user_name 
  "Vello Orumets #{Random.rand(10**6)}"
end

describe 'Chat REST API' do
  describe "creating new user" do
    it "POST /users creates new user" do
      name = unique_user_name
      response = HTTParty.post "#{api_base_address}/users", example_user_query_data(name)
      response.code.must_equal 201
      JSON.parse(response.body)['name'].must_equal name
    end

    it "POST /users twice with same name fails" do
      HTTParty.post "#{api_base_address}/users", example_user_query_data
      response = HTTParty.post "#{api_base_address}/users", example_user_query_data
      response.code.must_equal 422
    end
  end

  describe 'sending messages to chat' do

    it 'succeeds with name and text present in message' do
      name = unique_user_name
      HTTParty.post "#{api_base_address}/users", example_user_query_data(name)
      response = HTTParty.post "#{api_base_address}/messages", example_message_query(name, 'Hello!')
      response.code.must_equal 201

    end

    it 'fails when message is sent without username' do
      response = HTTParty.post "#{api_base_address}/messages", example_message_query(nil)
      response.code.must_equal 422
    end
    
    it 'fails with empty message' do
      name = unique_user_name
      HTTParty.post "#{api_base_address}/users", example_user_query_data(name)
      response = HTTParty.post "#{api_base_address}/messages", example_message_query(name, nil)
      response.code.must_equal 422
    end
  end

  describe 'getting previous messages' do
    it 'returns all messages by default' do
      name = unique_user_name
      HTTParty.post "#{api_base_address}/users", example_user_query_data(name)
      10.times do |count|
        HTTParty.post "#{api_base_address}/messages", example_message_query(name, "Zat is a message #{count}")
      end

      response = HTTParty.get "#{api_base_address}/messages"
      JSON.parse(response.body).length.must_be :>=, 10
    end
  end
end
