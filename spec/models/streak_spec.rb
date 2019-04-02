require 'rails_helper'

describe Streak, type: :model do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:streak) { create(:streak, user: user) }
  let!(:active_streak) { create(:streak, :active, user: user) }
  let!(:expiring_streak) { create(:streak, :expiring, user: other_user) }
  let!(:ended_streak) { create(:streak, :ended, user: user) }


  describe 'validations' do
    it "should be valid" do
      expect(active_streak).to be_valid
    end

    it "should not be valid without a first_course_date" do
      active_streak.update(first_course_date: nil)

      expect(active_streak).not_to be_valid
    end

    it "should not be valid without a last_course_date" do
      active_streak.update(last_course_date: nil)

      expect(active_streak).not_to be_valid
    end

    it "should not be valid without an active flag" do
      active_streak.update(active: nil)

      expect(active_streak).not_to be_valid
    end
  end

  describe 'initialization' do
    it "should return the correct default length" do
      expect(streak.length).to eql 1
    end

    it "should return the correct default first course date" do
      started_now = streak.first_course_date - Time.current < 1.second

      expect(started_now).to be_truthy
    end

    it "should return the correct default last course date" do
      started_now = streak.last_course_date - Time.current < 1.second

      expect(started_now).to be_truthy
    end

    it "should return the correct active value" do
      expect(streak.active).to eql true
    end
  end

  describe 'length' do
    it "should return the correct length" do
      expect(active_streak.length).to eql 6
    end
  end

  describe 'days_between_dates' do
    it "should return the correct number of days between two dates" do
      first_date = 1.day.ago
      second_date = Time.current

      expect(active_streak.days_in_date_range(first_date, second_date)).to eql 2
    end

    it "should return the correct number of days between two dates in reversed order" do
      first_date = 1.day.ago
      second_date = Time.current

      expect(active_streak.days_in_date_range(second_date, first_date)).to eql 2
    end
  end

  describe '#self.close_expired_streaks' do
    it "should return the correct number of active streaks" do
      expect(Streak.active.count).to eql 3

      Streak.close_expired_streaks

      expect(Streak.active.count).to eql 2
    end
  end

  describe '#expired?' do
    it "should be expired" do
      expect(expiring_streak.expired?).to eql true
    end

    it "should not be expired" do
      expect(active_streak.expired?).to eql false
    end
  end

  describe '#increment' do
    it "should not increment if active" do
      old_length = active_streak.length

      active_streak.update(active: false)
      active_streak.increment

      expect(active_streak.length).to eql old_length
    end
  end

  describe '#already_incremented_today?' do
    it "should increment if active and has not been incremented yet today" do
      active_streak.update(last_course_date: 1.day.ago)

      old_length = active_streak.length

      active_streak.increment

      expect(active_streak.length).to eql old_length + 1
    end

    it "should not increment if already incremented today" do
      old_length = active_streak.length

      active_streak.increment

      expect(active_streak.length).to eql old_length
    end
  end

  describe '#end' do
    it "should return an inactive streak" do
      expect(active_streak.active).to eql true

      active_streak.end

      expect(active_streak.active).to eql false
    end
  end
end
