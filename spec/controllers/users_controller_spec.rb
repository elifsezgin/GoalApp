require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders sign up page" do
      get :new, user: {}

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end
  describe "POST #create" do
    context "with valid params" do
      it "renders home page" do
        post :create, user: {username: 'elif', password: '123456'}
        user = User.find_by_username('elif')

        expect(response).to redirect_to(user_url(user))
        expect(response).to have_http_status(302)
      end

    end
    context "with invalid params" do
      it "renders sign up page" do
        post :create, user: {username: 'elif', password: '1234'}

        expect(response).to render_template("new")
        expect(flash[:errors]).to be_present
      end

    end
  end

end
