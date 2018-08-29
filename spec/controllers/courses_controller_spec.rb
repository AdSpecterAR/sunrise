require 'rails_helper'

describe CoursesController, type: :controller do
  let!(:instructor) { create(:user, :instructor) }
  let(:new_course_params) do
    {
      name: 'Strength and Conditioning',
      duration: 40,
      category: 'hiit',
      difficulty: 'challenging',
      instructor_id: instructor.id,
      description: 'this is a hard workout',
      equipment: 'yoga mat and water bottle'
    }
  end

  describe "#create" do
    it "creates a course" do
      post :create_course, params: { course: new_course_params }, format: :as_json
      expect(response).to be_success
    end

    it "fill in all the right fields" do
      post :create_course, params: { course: new_course_params }, format: :as_json
      response_json = parsed_response_json(response)

      expect(response_json[:course][:name]).to eql new_course_params[:name]
      expect(response_json[:course][:duration]).to eql new_course_params[:duration]
      expect(response_json[:course][:category]).to eql new_course_params[:category]
      expect(response_json[:course][:difficulty]).to eql new_course_params[:difficulty]
      expect(response_json[:course][:description]).to eql new_course_params[:description]
      expect(response_json[:course][:equipment]).to eql new_course_params[:equipment]
      expect(response_json[:course][:instructor_id]).to eql new_course_params[:instructor_id]
    end
  end

  describe "get_courses" do
    it "returns the right properties as JSON" do
      get :get_courses, format: :json

      expect(response).to be_success
      response_json = parsed_response_json(response)
      expect(response_json).to have_key :courses
    end
  end

end
