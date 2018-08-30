require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  let(:new_instructor_params) do
    {
        first_name: 'Steve',
        last_name: 'Kpa',
        email: 'steve@cloudworkout.com',
        password: 'password',
        instructor: true
    }
  end

  describe "create_instructor" do
    it "creates a new user with instructor = true" do
      post :create, params: { user: new_instructor_params }, format: :as_json
      expect(response).to be_success
      response_json = parsed_response_json(response)

      expect(response_json[:user][:first_name]).to eql new_instructor_params[:first_name]
      expect(response_json[:user][:last_name]).to eql new_instructor_params[:last_name]
      expect(response_json[:user][:email]).to eql new_instructor_params[:email]
      expect(response_json[:user][:instructor]).to eql true
    end
  end

end
