require 'rails_helper'

RSpec.describe Game, :type => :model do
  subject { described_class.new }

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:opponent) }
  end

  it "is valid with valid attributes" do
    User.create!(email: "test@regalii.com", password: "secret123")
    User.create!(email: "test2@regalii.com", password: "secret123")

    subject.user_score = 21
    subject.user = User.first
    subject.opponent = User.last

    expect(subject).to be_valid
  end

  it "is not valid without an user" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an opponent" do
    subject.opponent_id = nil
    expect(subject).to_not be_valid
  end

  it "it requires a winner" do
    User.create!(email: "test@regalii.com", password: "secret123")
    User.create!(email: "test2@regalii.com", password: "secret123")

    subject.user = User.first
    subject.opponent = User.last

    expect(subject).to_not be_valid
  end

end

