require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  let!(:user) { create(:user) }

  let(:stripe_params) do
    {
      user_id: user.id,
      stripeToken: 'tok_ca',
      amount: 500,
      description: 'charge',
      currency: 'usd'
    }
  end

  describe 'create' do
    it "successfully creates a new customer and charge" do
      user.update(stripe_customer_id: nil)
      post :create, params: { charge: stripe_params }, format: :as_json
      
      expect(response).to be_success

      user.reload

      expect(user.stripe_customer_id).not_to be_nil
    end

    it "doesn't create a new customer if user already has customer id" do
      user.update(stripe_customer_id: nil)
      post :create, params: { charge: stripe_params }, format: :as_json

      expect(response).to be_success
      user.reload
      @customer_id = user.stripe_customer_id
      expect(@customer_id).not_to be_nil

      post :create, params: { charge: stripe_params }, format: :as_json

      user.reload
      expect(user.stripe_customer_id).to eql @customer_id
    end
  end

end
