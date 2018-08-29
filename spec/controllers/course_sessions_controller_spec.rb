require 'rails_helper'

RSpec.describe CourseSessionsController, type: :controller do

  let!(:instructor) { create(:user, :instructor) }
  let!(:student) { create(:user, :student) }
  let!(:student2) { create(:user, :student) }
  let!(:course) { create(:course, instructor: instructor) }
  let!(:course_session) { create(:course_session, course: course) }
  let!(:user_course_session) { create(:user_course_session, student: student, course_session: course_session) }
  let!(:user_course_session2) { create(:user_course_session, student: student2, course_session: course_session) }
  let(:new_course_session_params) do
    {
        start_time: DateTime.new(2018, 2, 13, 2, 30, 0, 0),
        duration: 30,
        video_url: 'youtube.com',
        thumbnail_image_url: 'instagram.com',
        course_id: course.id,
    }
  end


  describe "create_course_sessions" do
    it "creates a course_session" do
      post :create_course_session, params: { course_session: new_course_session_params }, format: :as_json
      expect(response).to be_success
    end

    it "fills in all the right fields" do
      post :create_course_session, params: { course_session: new_course_session_params }, format: :as_json
      response_json = parsed_response_json(response)

      # expect(response_json[:course_session][:start_time]).to eql DateTime.new(2018, 2, 13, 2, 30, 0, 0)
      expect(response_json[:course_session][:duration]).to eql new_course_session_params[:duration]
      expect(response_json[:course_session][:video_url]).to eql new_course_session_params[:video_url]
      expect(response_json[:course_session][:thumbnail_image_url]).to eql new_course_session_params[:thumbnail_image_url]
      expect(response_json[:course_session][:course_id]).to eql new_course_session_params[:course_id]
    end

  end

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
      expect(response_json).to have_key :participants
      expect(response_json[:participants].size).to eql 2
      expect(response_json[:participants]).to contain_exactly(student.full_name, student2.full_name)
    end
  end

end

