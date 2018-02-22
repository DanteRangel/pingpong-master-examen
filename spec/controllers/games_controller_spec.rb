require 'rails_helper'

RSpec.describe GamesController do

  describe "GET #index" do
    it "populates list of games" do
      User.create!(email: "test@regalii.com", password: "secret123")

      user = User.first
      sign_in user

      get :index

      expect(assigns(:games)).to eq(user.games)
      expect(response).to be_success
    end
  end


end
