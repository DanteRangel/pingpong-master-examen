module GamesHelper
  def opponent(game)
    if current_user == game.user
      game.opponent
    else
      game.user
    end
  end

  def result(game)
    if current_user == game.user
      if game.won
        "W"
      else
        "L"
      end
    else
      if game.won
        "L"
      else
        "W"
      end
    end
  end

  def score(game)
    if current_user == game.user
      "#{game.user_score}-#{game.opponent_score}"
    else
      "#{game.opponent_score}-#{game.user_score}"
    end
  end
end
