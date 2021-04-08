require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/v1" do
    it "returns http success" do
      get "/users/api/v1"
      expect(response).to have_http_status(:success)
    end
  end

end
