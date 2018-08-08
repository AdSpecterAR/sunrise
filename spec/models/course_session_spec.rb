require 'rails_helper'

RSpec.describe CourseSession, type: :model do
  let(:instructor) { create(:user, :instructor) }
  let(:student1) { create(:user) }
  let(:student2) { create(:user) }
  let(:student3) { create(:user) }
  let(:course) { create(:course, instructor: instructor) }
  let!(:course_session1) { create(:course_session, course: course, start_time: Time.now, duration: 45) }
  let!(:course_session2) { create(:course_session, course: course, start_time: 59.minutes.ago) }
  let!(:course_session3) { create(:course_session, course: course, start_time: 2.hours.from_now) }
  let!(:course_session4) { create(:course_session, course: course, start_time: 4.days.ago) }
  let!(:course_session5) { create(:course_session, course: course, start_time: 8.days.from_now) }
  let!(:user_course_session1) { create(:user_course_session, student: student1, course_session: course_session1) }
  let!(:user_course_session2) { create(:user_course_session, student: student2, course_session: course_session1) }

  describe 'validations' do
    it "is valid with valid attributes" do
      expect(course_session1).to be_valid
    end

    it "is invalid without a start time" do
      course_session1.update(start_time: nil)

      expect(course_session1).not_to be_valid
    end

    it "is valid without a duration" do
      course_session1.update(duration: nil)

      expect(course_session1).to be_valid
    end

  end

  describe 'associations' do
    it "must belong to a course" do
      course_session1.update(course: nil)

      expect(course_session1).not_to be_valid
    end
  end

  describe 'courses_in_next_week' do
    it "correctly return all valid course sessions in the specified time period" do
      expect(CourseSession.courses_in_next_week).to match_array [course_session1, course_session2, course_session3]
    end

    it "returns array sorted by start_time" do
      expect(CourseSession.courses_in_next_24_hours[0]).to eql course_session2
      expect(CourseSession.courses_in_next_24_hours[1]).to eql course_session1
      expect(CourseSession.courses_in_next_24_hours[2]).to eql course_session3
    end
  end

  describe 'duration' do
    it "uses course session duration if duration field is present" do
      expect(course_session1.duration).to eql 45
    end

    it "uses default course duration if course session duration is not present" do
      course_session1.update(duration: nil)

      expect(course_session1.duration).to eql 30
    end
  end

  describe 'instructor_name' do
    it "returns the correct instructor full name" do
      expect(course_session1.instructor_full_name).to eql "#{instructor.first_name} #{instructor.last_name}"
    end
  end

  describe 'all_participants' do
    it "correctly returns the full names of all participants" do
      expect(course_session1.all_participants.size).to eql 2
      expect(course_session1.all_participants).to match_array [student1.full_name, student2.full_name]
    end
  end
end
