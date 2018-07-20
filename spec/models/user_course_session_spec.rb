require 'rails_helper'

RSpec.describe UserCourseSession, type: :model do
  let(:instructor) { create(:user, :instructor) }
  let(:student) { create(:user, :student) }
  let(:course) { create(:course, instructor: instructor) }
  let(:course_session) { create(:course_session, course: course) }
  let(:user_course_session) { create(:user_course_session, student: student, course_session: course_session) }


  describe 'validations' do
    it "it valid with valid attributes" do
      expect(user_course_session).to be_valid
    end
  end
end
