require 'sinatra'
require 'json'
require 'rest-client'

headers = {
  authorization: "Bearer #{ENV['SUPERVISOR_TOKEN']}",
  content_type: :json,
}

set :port, 3000
set :bind, '0.0.0.0'

post '/' do
  payload = JSON.load(request.body.read)
  bomb_state = payload.dig('round', 'bomb')
  result = RestClient.post(
    'http://supervisor/core/api/states/csgo.bomb',
    {state: bomb_state}.to_json,
    headers,
  )
end