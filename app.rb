require 'sinatra/base'
require_relative 'lib/player'
require_relative 'lib/game'

class Battle < Sinatra::Base
  enable :sessions
  get '/' do
    erb :index
  end

  post '/names' do
    player1 = Player.new(params[:player1])
    player2 = Player.new(params[:player2])
    $game = Game.new(player1, player2)
    redirect to('/play')
  end

  get '/play' do
    @game = $game
    erb :play
  end

  get '/attack' do
    @game = $game
    @game.attack(@game.player2)
    @game.switch_player
    # @player1 = $game.player1.name
    # @player2 = $game.player2.name
    # @points = $game.player2.points
    erb :attack
  end

  # start the server if ruby file executed directly
 run! if app_file == $0
end
