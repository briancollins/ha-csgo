require 'sinatra'
require 'json'
require 'rest-client'

headers = {
  authorization: "Bearer #{ENV['SUPERVISOR_TOKEN']}",
  content_type: :json,
}

set :port, 3000
set :bind, '0.0.0.0'

last_bomb_state = nil
last_map_phase = nil
last_team = nil

post '/' do
  payload = JSON.load(request.body.read)
  bomb_state = payload.dig('round', 'bomb') || 'null'
  if bomb_state != last_bomb_state
    last_bomb_state = bomb_state
    result = RestClient.post(
      'http://supervisor/core/api/states/csgo.bomb',
      {state: bomb_state}.to_json,
      headers,
    )
  end

  map_phase = payload.dig('map', 'phase') || 'null'
  if map_phase != last_map_phase
    last_map_phase = map_phase
    result = RestClient.post(
      'http://supervisor/core/api/states/csgo.phase',
      {state: map_phase}.to_json,
      headers,
    )
  end

  team = payload.dig('player', 'team') || 'null'
  if team != last_team
    last_team = team
    result = RestClient.post(
      'http://supervisor/core/api/states/csgo.team',
      {state: team}.to_json,
      headers,
    )
  end
end