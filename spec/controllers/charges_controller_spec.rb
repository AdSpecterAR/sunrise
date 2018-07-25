require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  let!(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }

  let!(:charge_params) do
    {
      user_id: user.id,
      stripeToken: 'tok_ca',
      amount: 500,
      description: 'charge',
      currency: 'usd',

    }
  end

  let!(:stripe_plan) do
    Stripe::Plan.retrieve(plan.stripe_plan_id)
  end

  let!(:subscribe_params) do
    {
      user_id: user.id,
      plan_id: stripe_plan.id,
      stripeToken: 'tok_ca',
      trial_period_days: 14
    }
  end

  let!(:cancel_params) do
    {
        user_id: user.id
    }
  end

  describe 'create' do
    it "successfully creates a new customer and charge" do
      user.update(stripe_customer_id: nil)
      post :create, params: { charge: charge_params }, format: :as_json
      
      expect(response).to be_success

      user.reload

      expect(user.stripe_customer_id).not_to be_nil
    end

    it "doesn't create a new customer if user already has customer id" do
      user.update(stripe_customer_id: nil)
      post :create, params: { charge: charge_params }, format: :as_json

      # create
      expect(response).to be_success
      user.reload
      @customer_id = user.stripe_customer_id
      expect(@customer_id).not_to be_nil

      post :create, params: { charge: charge_params }, format: :as_json

      user.reload
      expect(user.stripe_customer_id).to eql @customer_id
    end
  end

  describe 'subscribe' do
    it "returns a subscription" do
      user.update(stripe_customer_id: nil) #had to put this line in because out test customer hit max subsriptions
      post :subscribe, params: { subscription: subscribe_params }, format: :as_json
      user.reload
      expect(user.stripe_customer_id).not_to be_nil
      expect(response).to be_success
      response_json = parsed_response_json(response)

      expect(response_json).to have_key :stripe
      expect(response_json[:stripe]).to have_key :customer
      expect(response_json[:stripe][:customer]).to eql user.stripe_customer_id
      expect(response_json[:stripe]).to have_key :plan
      expect(response_json[:stripe][:plan][:id]).to eql plan.stripe_plan_id
      expect(user.plan).not_to be_nil
      #expect(response_json[:stripe][:trial_period_days]).to eql subscribe_params[:trial_period_days]
    end

    it "doesn't update stripe customer id if user already has one" do
      user.update(stripe_customer_id: nil)
      post :subscribe, params: { subscription: subscribe_params }, format: :as_json

      expect(response).to be_success
      user.reload
      @customer_id = user.stripe_customer_id
      expect(@customer_id).not_to be_nil

      post :subscribe, params: { subscription: subscribe_params }, format: :as_json

      user.reload
      expect(user.stripe_customer_id).to eql @customer_id
    end
  end

  describe "add_subscription" do
    it "updates the users subscription" do
      user.update(stripe_customer_id: nil)
      post :subscribe, params: { subscription: subscribe_params }, format: :as_json
      user.reload
      expect(user.stripe_customer_id).not_to be_nil
      expect(response).to be_success
      response_json = parsed_response_json(response)
      expect(user.stripe_subscription_id).to eql response_json[:stripe][:id]
      expect(user.plan).not_to be_nil

    end
    #TODO: what should u do if you add a sub but you already have one?
  end

  describe "cancel_subscription" do
    it "returns the subscription cancelled" do
      user.update(stripe_customer_id: nil)
      post :subscribe, params: { subscription: subscribe_params }, format: :as_json
      user.reload
      expect(user.stripe_customer_id).not_to be_nil
      expect(response).to be_success

      post :cancel_subscription, params: { subscription: cancel_params }, format: :as_json
      response_json = parsed_response_json(response)
      expect(response_json[:stripe][:cancel_at_period_end]).to eql true
    end
    it "removes the subscription id from user" do
      user.update(stripe_customer_id: nil)
      post :subscribe, params: { subscription: subscribe_params }, format: :as_json
      user.reload
      expect(user.stripe_subscription_id).not_to be_nil
      expect(response).to be_success

      post :cancel_subscription, params: { subscription: cancel_params }, format: :as_json
      user.reload
      expect(user.stripe_subscription_id).to be_nil
      expect(user.plan).to be_nil
    end
  end

end
