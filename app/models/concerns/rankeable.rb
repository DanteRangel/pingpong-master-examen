module Rankeable
  extend ActiveSupport::Concern

  def update_rating! game
    ratings = new_ratings(self.rating, game.opponent.rating, game.won ? 1:0)

    self.update_column :rating, ratings['player1']
    game.opponent.update_column :rating, ratings['player2']
  end

  def new_ratings(player1_rating,player2_rating,result,k_value=32,should_round=true)
    #Asignar resultados individuales 
    player1_result = result
    player2_result = 1 - result

    #Calcula los resultados esperados
    player1_expectation = 1/(1+10**((player2_rating - player1_rating)/400.0)) #the .0 is important to force float operations!))
    player2_expectation = 1/(1+10**((player1_rating - player2_rating)/400.0))

    #Calcula nuevos ratings
    player1_new_rating = player1_rating + (k_value*(player1_result - player1_expectation))
    player2_new_rating = player2_rating + (k_value*(player2_result - player2_expectation))

    #Ronda opcional
    if should_round
      player1_new_rating = player1_new_rating.round
      player2_new_rating = player2_new_rating.round
    end

    # Crea un diccionario
    new_ratings_hash = Hash.new
    new_ratings_hash['player1'] = player1_new_rating
    new_ratings_hash['player2'] = player2_new_rating

    new_ratings_hash
  end
end
