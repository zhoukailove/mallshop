require 'rails_helper'

RSpec.describe "Admin::Classifications", :type => :request do
  describe "GET /admin_classifications" do
    it "works! (now write some real specs)" do
      get admin_classifications_path
      expect(response).to have_http_status(200)
    end
  end
end
