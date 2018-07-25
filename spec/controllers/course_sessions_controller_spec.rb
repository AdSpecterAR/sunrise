require 'rails_helper'

RSpec.describe CourseSessionsController, type: :controller do

  let!(:instructor) { create(:user, :instructor) }
  let!(:student) { create(:user, :student) }
  let!(:student2) { create(:user, :student) }
  let!(:course) { create(:course, instructor: instructor) }
  let!(:course_session) { create(:course_session, course: course) }
  let!(:user_course_session) { create(:user_course_session, student: student, course_session: course_session) }
  let!(:user_course_session2) { create(:user_course_session, student: student2, course_session: course_session) }


  describe "upcoming courses" do
    it "returns the right properties as JSON" do
      get :upcoming_courses, format: :json

      expect(response).to be_success
    end
  end

  describe "get users" do
    it "returns the names of the users in this course" do
      get :get_students, params: { course_session_id: course_session.id }, format: :json

      expect(response).to be_success
      response_json = parsed_response_json(response)
      expect(response_json).to have_key :user
      expect(response_json[:user]).to contain_exactly(student.full_name, student2.full_name)
    end
  end


end

