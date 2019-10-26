require 'sinatra/base'
require 'tilt/erb'

class WebApp < Sinatra::Application
  configure :test do
    enable :raise_errors
    disable :show_exceptions, :logging
  end

  def initialize(app = nil, people = {})
    super(app)
    @people = people
  end

  get "/" do
    messages_heard = @people[params['name']].messages_heard
    erb :index, { locals: {
      person_name: params['name'],
      messages_heard: messages_heard }
    }
  end

  post "/shouts" do
    shouter = @people[params['name']]
    shouter.shout(params[:message])
    redirect "/?name=#{params['name']}"
  end

  before do
    error(401) unless @people.key?(params['name'])
  end

  error 401 do
    "Unauthorized."
  end

end
