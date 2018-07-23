require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  let!(:user) { create(:user) }

  let(:charge_params) do
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
     # @user = User.find_by_id(charge_params[:user_id])
      expect(@user).to have_attributes(:stripe_customer_id => nil)
      post :create, params: { charge: charge_params }, format: :as_json
      
      expect(@user).not_to have_attributes(:stripe_customer_id => nil)

      expect(response).to be_success
    end

    it "doesn't create a new customer if user already has customer id" do
      post :create, params: { charge: charge_params }, format: :as_json

    end
  end

end
