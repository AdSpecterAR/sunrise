require 'rails_helper'

describe User, type: :model do
  let!(:user) { create(:user) }
  let!(:active_streak) { create(:streak, :active, user: user) }
  let!(:ended_streak) { create(:streak, :ended, user: user) }
  let!(:expiring_streak) { create(:streak, :expiring, user: user) }
  let!(:longest_streak) { create(:streak, :longest, user: user) }


  describe 'initialization' do
    it "should return the correct default minutes exercised" do
      expect(user.minutes_exercised).to eql 0
      expect(user.minutes_exercised).not_to be_nil
    end
  end

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
  end

  describe '#current_streaks' do
    it "should return the correct current streak" do
      expect(user.current_streak.id).to eql active_streak.id
    end
  end

  describe '#start_or_increment_streak' do
    it "should increment the existing current streak" do
      active_streak.update(last_course_date: 1.day.ago)

      starting_streak_length = user.current_streak.length

      user.start_or_increment_streak

      expect(user.current_streak.length).to eql starting_streak_length + 1
    end

    it "should start a new streak" do
      old_streak = user.current_streak.dup
      old_streak.update(active: false)

      user.start_or_increment_streak

      expect(user.current_streak.id).not_to eql old_streak.id
    end
  end

  describe '#longest_streak' do
    it "should return the longest streak" do
      expect(user.longest_streak.id).to eql longest_streak.id
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
end
