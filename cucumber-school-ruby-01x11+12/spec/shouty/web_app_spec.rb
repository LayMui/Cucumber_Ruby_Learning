ENV['RACK_ENV'] = 'test'
require 'shouty/web_app'
require 'rack/test'
require 'capybara'

describe WebApp do
  include Rack::Test::Methods

  let(:app) { WebApp.new(nil, people) }
  let(:people) { { 'Sean' => sean } }
  let(:sean) { double(messages_heard: []) }
  let(:page) { Capybara.string(last_response.body) }

  describe "GET /" do

    it "returns a homepage when a registered user's name is specified in the URL" do
      get '/?name=Sean'
      expect(last_response).to be_ok
    end

    it "returns 401 when the user is not recognised" do
      get '/?name=Unknown'
      expect(last_response.status).to eq 401
      expect(last_response.body).to match /unauthorized/i
    end

    it "renders a form for posting messages on the homepage" do
      get '/?name=Sean'
      expect(page).to have_css('form [name=message]')
      expect(page).to have_css('form [type=submit]')
    end

    it "displays the messages heard by the user" do
      people['Lucy'] = double(messages_heard: ['one', 'two'])
      get '/?name=Lucy'
      expect(page).to have_css('.message', text: /one/)
      expect(page).to have_css('.message', text: /two/)
    end
  end

  describe "POST /shouts" do

    it "returns 401 when the user is not recognised" do
      post '/shouts', { name: 'Unknown', message: 'Test Message' }
      expect(last_response.status).to eq 401
      expect(last_response.body).to match /unauthorized/i
    end

    it "shouts a message from the given user" do
      expect(sean).to receive(:shout).with('Test Message')
      post '/shouts', { name: 'Sean', message: 'Test Message' }
    end

    it "redirects back to the homepage, keeping the user logged in" do
      allow(sean).to receive(:shout)
      post '/shouts', { name: 'Sean', message: 'Test Message' }
      expect(last_response).to be_redirect
      expect(last_response.location).to eq "http://example.org/?name=Sean"
    end
  end
end
