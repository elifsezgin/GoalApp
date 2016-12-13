require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
  let(:kathy) {User.create!(username: 'kalu', password:"123456")}
  let(:mygoal) {Goal.create(title: "test goal", description: 'test test')}
  describe "GET #new" do
    it "renders new goals page" do
      get :new, goal: {}

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end
  describe "POST #create" do
    context 'when logged in' do
      before(:each) do
        allow(controller).to receive(:current_user) { kathy }
      end

      context "with valid params" do
        it "renders goal page" do
          post :create, goal: {title: "test goal", description: 'test test'}
          goal = Goal.find_by_title('test goal')

          expect(response).to redirect_to(goal_url(goal))
          expect(response).to have_http_status(302)
        end
      end
      context "with invalid params" do
        it "renders new goal page" do
          post :create, goal: {title: "", description: 'test test'}

          expect(response).to render_template("new")
          expect(flash[:errors]).to be_present
        end
      end
    end
    context 'when not logged in' do
      it 'redirects to log in page' do
        get :new, goal: {}

        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  # describe "GET #edit" do
  #   context 'when logged in' do
  #     before(:each) do
  #       allow(controller).to receive(:current_user) { kathy }
  #     end
  #     it 'redirects to goals show page on success'
  #     patch :update, goal: {description: 'test test 12'}
  #     goal = Goal.find_by_title('test goal')
  #
  #     expect(response).to redirect_to(goal_url(goal))
  #     expect(response).to have_http_status(302)
  #   end
  #   context 'when not logged in' do
  #     get :edit, goal: {}
  #
  #     expect(response).to redirect_to(new_session_url)
  #   end
  # end

end
