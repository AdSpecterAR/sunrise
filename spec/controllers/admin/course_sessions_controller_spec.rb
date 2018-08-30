require 'rails_helper'

RSpec.describe Admin::CourseSessionsController, type: :controller do

  let!(:instructor) { create(:user, :instructor) }
  let!(:course) { create(:course, instructor: instructor) }
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
      post :create, params: { course_session: new_course_session_params }, format: :as_json
      expect(response).to be_success
    end

    it "fills in all the right fields" do
      post :create, params: { course_session: new_course_session_params }, format: :as_json
      response_json = parsed_response_json(response)

      # expect(response_json[:course_session][:start_time]).to eql DateTime.new(2018, 2, 13, 2, 30, 0, 0)
      expect(response_json[:course_session][:duration]).to eql new_course_session_params[:duration]
      expect(response_json[:course_session][:video_url]).to eql new_course_session_params[:video_url]
      expect(response_json[:course_session][:thumbnail_image_url]).to eql new_course_session_params[:thumbnail_image_url]
      expect(response_json[:course_session][:course_id]).to eql new_course_session_params[:course_id]
    end
  end
end
