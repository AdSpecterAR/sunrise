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
        first_name: 'Jess',
        last_name: 'Zhang',
        email: 'incorrectemailformat.com',
        password: 'password2'
    }
  end

  let(:facebook_params) do
    {
        first_name: 'Mark',
        last_name: 'Zuck',
        email: 'mark.zuck@berg.com',
        password: 'beepbeepbop',
        fb_authentication_token: 'fjdh3g4j4k55fijd####4k',
        fb_user_id: '8563528909876396',
        fb_account: true
    }
  end

  describe "#create" do

    it "creates a new user with email" do
      post :create, params: { user: new_user_params }, format: :as_json
      expect(response).to be_success
    end

    it "fills in all the right fields in User" do
      post :create, params: { user: new_user_params }, format: :as_json
      response_json = parsed_response_json(response)

      expect(response_json).to have_key :user
      expect(response_json[:user]).to have_key :first_name
      expect(response_json[:user]).to have_key :last_name
      expect(response_json[:user]).to have_key :email
    end

    it "fill the user fields with the right values" do
      post :create, params: { user: new_user_params }, format: :as_json
      response_json = parsed_response_json(response)

      expect(response_json[:user][:first_name]).to eql new_user_params[:first_name]
      expect(response_json[:user][:last_name]).to eql new_user_params[:last_name]
      expect(response_json[:user][:email]).to eql new_user_params[:email]
    end

    it "doesn't accept invalid params" do
      post :create, params: { user: bad_user_params }, format: :as_json
      expect(response).not_to be_success
    end

  end

  describe "facebook" do

    it "creates a new user with facebook" do
      post :create, params: { user: facebook_params }, format: :as_json
      expect(response).to be_success
    end

    it "fills in all the right fields in User" do
      post :create, params: { user: facebook_params }, format: :as_json
      response_json = parsed_response_json(response)

      expect(response_json).to have_key :user
      expect(response_json[:user]).to have_key :first_name
      expect(response_json[:user]).to have_key :last_name
      expect(response_json[:user]).to have_key :email
      expect(response_json[:user]).to have_key :fb_authentication_token
      expect(response_json[:user]).to have_key :fb_user_id
      expect(response_json[:user]).to have_key :fb_account
    end

    it "fill the user fields with the right values" do
      post :create, params: { user: facebook_params }, format: :as_json
      response_json = parsed_response_json(response)

      expect(response_json[:user][:first_name]).to eql facebook_params[:first_name]
      expect(response_json[:user][:last_name]).to eql facebook_params[:last_name]
      expect(response_json[:user][:email]).to eql facebook_params[:email]
      expect(response_json[:user][:fb_authentication_token]).to eql facebook_params[:fb_authentication_token]
      expect(response_json[:user][:fb_user_id]).to eql facebook_params[:fb_user_id]
      expect(response_json[:user][:fb_account]).to eql facebook_params[:fb_account]
    end

  end

end
