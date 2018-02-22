class Game < ActiveRecord::Base
  belongs_to :user
  belongs_to :opponent, class_name: 'User'

  before_save :calculate_result
  after_create :update_ratings

  scope :of_user, ->(user) {
    games = Game.arel_table
    where(games[:user_id].eq(user).or(games[:opponent_id].eq(user)))
  }

  validates_presence_of :user_id, :opponent_id
  validate :has_winner

  def calculate_result
    if user_score > opponent_score
      self.won = true
    end
  end

  def has_winner
    if user_score == 21
      return true if opponent_score < user_score
    elsif opponent_score == 21
      return true if user_score < opponent_score
    end

    errors.add(:base, "Debe haber un jugador ganador con puntaje 21")
    return false
  end

  def update_ratings
    user.update_rating! self
  end

end
