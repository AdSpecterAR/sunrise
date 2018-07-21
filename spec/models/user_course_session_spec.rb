require 'rails_helper'

RSpec.describe UserCourseSession, type: :model do
  let!(:instructor) { create(:user, :instructor) }
  let!(:student) { create(:user, :student) }
  let!(:student2) { create(:user, :student) }
  let!(:course) { create(:course, instructor: instructor) }
  let!(:course_session) { create(:course_session, course: course) }
  let!(:course_session2) { create(:course_session, course: course) }
  let!(:user_course_session) { create(:user_course_session, student: student, course_session: course_session) }


  describe 'validations' do
    it "it valid with valid attributes" do
      expect(user_course_session).to be_valid
    end
  end

  describe 'find_or_create_session' do
    it "finds a user_course_session that exists" do
      expect(UserCourseSession.find_or_create_session(student, course_session)).to eql user_course_session
    end

    it "creates a user course session that doesn't exist" do
      @user_course_session2 = UserCourseSession.find_or_create_session(student2, course_session)
      expect(@user_course_session2.student_id).to eql student2.id
      expect(@user_course_session2.course_session_id).to eql course_session.id
    end
  end
end
