require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user, :instructor) }

=begin
  let!(customer_params) do
    {
        stripeToken: 'tok_ca',
    }
  end
=end

  describe 'validations' do
    it "should be valid" do
      expect(user).to be_valid
    end

    it "should not be valid without a first name" do
      user.update(first_name: nil)

      expect(user).not_to be_valid
    end

    it "should not be valid without a last name" do
      user.update(last_name: nil)

      expect(user).not_to be_valid
    end

    it "should not be valid without the correct email format" do
      user.update(email: "john@adspectercom")

      expect(user).not_to be_valid
    end

  end

  describe 'find or create customers' do
    it "should return a new customer if user has no customer" do
      user.update(stripe_customer_id: nil)
      expect(user.stripe_customer_id).to be_nil
      user.find_or_create_stripe_customer('tok_ca')
      expect(user.stripe_customer_id).not_to be_nil
    end

    it "should return the same customer if user already has one" do
      user.update(stripe_customer_id: nil)
      expect(user.stripe_customer_id).to be_nil
      user.find_or_create_stripe_customer('tok_ca')
      expect(user.stripe_customer_id).not_to be_nil

      @customer_id = user.stripe_customer_id
      user.find_or_create_stripe_customer('tok_ca')
      expect(user.stripe_customer_id).to eql @customer_id
    end

  end

  describe 'add_subscription' do
    it "should add subsctiption id to user table" do
      user.update(stripe_subscription_id: nil)
      expect(user.stripe_subscription_id).to be_nil
      user.add_subscription("sub_DHjbbsYn8jxp1H")
      expect(user.stripe_subscription_id).not_to be_nil
    end
  end

  describe 'cancel_subscription' do
    it "removes stripe subsciption id" do

      user.add_subscription("sub_DHjbbsYn8jxp1H")
      expect(user.stripe_subscription_id).not_to be_nil
      user.cancel_subscription
      expect(user.stripe_subscription_id).to be_nil
    end
  end
end
