require 'minitest/autorun'
require 'minitest/reporters'

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

describe 'Chat REST API' do
  describe "when asked about cheeseburgers" do
    it "must respond positively" do
      "Hello!".must_equal "Hello!"
    end
  end
end