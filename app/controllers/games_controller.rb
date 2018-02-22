class GamesController < ApplicationController
  # GET /games
  def index
    @games = current_user.games
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.user = current_user

    if @game.save
      redirect_to history_path, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:date_played, :user_id, :opponent_id, :user_score, :opponent_score)
    end
end
