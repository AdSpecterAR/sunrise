require 'rails_helper'

RSpec.describe Plan, type: :model do
  let!(:user) { create(:user) }
  let!(:plan) { create(:plan, user: user) }


  describe 'validations' do
    it "it valid with valid attributes" do
      expect(plan).to be_valid
    end

    it "is invalid without a name" do
      plan.update(name: nil)

      expect(plan).not_to be_valid
    end

    it "is invalid without the available attribute" do
      plan.update(available: nil)

      expect(plan).not_to be_valid
    end

    it "is invalid without the active attribute" do
      plan.update(active: nil)

      expect(plan).not_to be_valid
    end

    it "is invalid without a Stripe Plan ID" do
      plan.update(stripe_plan_id: nil)

      expect(plan).not_to be_valid
    end

    it "is invalid without a valid interval" do
      plan.update(interval: 'biweekly')

      expect(plan).not_to be_valid
    end

    it "is invalid without an associated user" do
      plan.update(user: nil)

      expect(plan).not_to be_valid
    end
  end
end
