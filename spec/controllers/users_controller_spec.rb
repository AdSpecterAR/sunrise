require 'rails_helper'

describe UsersController, type: :controller do
  let(:new_user_params) do
    {
      first_name: 'John',
      last_name: 'Li',
      email: 'john@adspecter.com',
      password: 'password1'
    }
  end

  let(:bad_user_params) do
    {
        first_name: 'jess',
        last_name: 'Zhanfg',
        email: 'bad.com',
        password: 'haha'
    }
  end

  describe "#create" do

    it "creates a new user" do
      post :create, params: { user: new_user_params }, format: :as_json

      expect(response).to be_success
    end

    it "doesn't accept invalid params" do
      post :create, params: { user: bad_user_params }, format: :as_json
      expect(response).not_to be_success
    end

    it "logs user in after signing up"

  end
end
