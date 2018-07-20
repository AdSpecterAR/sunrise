require 'rails_helper'

RSpec.describe CourseSession, type: :model do
  let(:instructor) { create(:user, :instructor) }
  let(:course) { create(:course, instructor: instructor) }
  let(:course_session) { create(:course_session, course: course) }
  let(:course_session1) { create(:course_session, course: course, start_time: Time.now) }
  let(:course_session2) { create(:course_session, course: course, start_time: 59.minutes.ago) }
  let(:course_session3) { create(:course_session, course: course, start_time: 2.hours.from_now) }
  let(:course_session4) { create(:course_session, course: course, start_time: 4.hours.ago) }
  let(:course_session5) { create(:course_session, course: course, start_time: 25.hours.from_now) }

  describe 'validations' do
    it "is valid with valid attributes" do
      expect(course_session).to be_valid
    end

    it "is invalid without a start time" do
      course_session.update(start_time: nil)

      expect(course_session).not_to be_valid
    end

  end

  describe 'associations' do
    it "must belong to a course" do
      course_session.update(course: nil)
      expect(course_session).not_to be_valid
    end
  end

  describe 'courses_in_next_24_hours' do

    it "returns something" do
      expect(CourseSession.courses_in_next_24_hours).to be
    end

    it "does not include sessions with start_date after 24 hours" do
      expect(CourseSession.courses_in_next_24_hours).not_to include(course_session5)
    end

    it "does not include sessions with start_date before 1 hour ago" do
      expect(CourseSession.courses_in_next_24_hours).not_to include(course_session4)
    end

    it "includes sessions with start_date including and before 24 hours from now" do
      course_session.update(start_time: 24.hours.from_now)
      expect(CourseSession.courses_in_next_24_hours).to include(course_session)
    end

    it "includes sessions with start_date including and after 1 hour ago" do
      expect(CourseSession.courses_in_next_24_hours).to include(course_session2)
    end
    
    it "returns array sorted by start_time" do
      puts CourseSession.courses_in_next_24_hours
      expect(CourseSession.courses_in_next_24_hours.first).to eql course_session2
      expect(CourseSession.courses_in_next_24_hours[1]).to be(course_session1)
      expect(CourseSession.courses_in_next_24_hours[2]).to be(course_session)
      expect(CourseSession.courses_in_next_24_hours[3]).to be(course_session3)
    end
  end
end
