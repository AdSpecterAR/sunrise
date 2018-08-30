require 'rails_helper'

describe CoursesController, type: :controller do
  let!(:instructor) { create(:user, :instructor) }

  describe "get_courses" do
    it "returns the right properties as JSON" do
      get :get_courses, format: :json

      expect(response).to be_success
      response_json = parsed_response_json(response)
      expect(response_json).to have_key :courses
    end
  end

end
