require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.email = "test@regalii.com"
    subject.password = "secret123"
    subject.password_confirmation = "secret123"

    expect(subject).to be_valid
  end

  it "starts with no rating" do
    expect(subject.rating).to be == 0
  end

  it "increases his ranking winning games" do
    User.create!(email: "test@regalii.com", password: "secret123")
    User.create!(email: "test2@regalii.com", password: "secret123")

    user = User.first
    oponnent = User.last

    game = Game.new
    game.user_score = 21
    game.opponent_score = 10
    game.user = user
    game.opponent = oponnent
    game.save

    expect(user.rating).to be > oponnent.rating
  end

end

