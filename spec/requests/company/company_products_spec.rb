require 'rails_helper'

RSpec.describe "Company::Products", :type => :request do
  describe "GET /company_products" do
    it "works! (now write some real specs)" do
      get company_products_path
      expect(response).to have_http_status(200)
    end
  end
end
