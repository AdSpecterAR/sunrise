require 'rails_helper'

RSpec.describe UserCourseSessionsController, type: :controller do

  let!(:instructor) { create(:user, :instructor) }
  let!(:student) { create(:user, :student) }
  let!(:course) { create(:course, instructor: instructor) }
  let!(:course_session) { create(:course_session, course: course) }
  let!(:user_course_session) { create(:user_course_session, student: student, course_session: course_session) }

  let(:feedback_params) do
    {
        rating: 'thumbs down',
        comment: 'boooo, you suck!'
    }
  end

  describe 'get_user_course_session' do
    it "returns the thing" do
      get :get_user_course_session, params: { :user_id => student.id, :course_session_id => course_session.id }, format: :as_json

      expect(response).to be_success
    end
  end

  describe 'post_feedback' do
    it "fills in the feedback" do
      post :post_feedback,
           params:
               { feedback: feedback_params , :user_course_session => user_course_session.id}

      expect(response).to be_success
    end
  end

end
