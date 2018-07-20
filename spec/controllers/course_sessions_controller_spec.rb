require 'rails_helper'

describe CourseSessionsController, type: :controller do

  it "returns the right properties as JSON" do
    get :upcoming_courses, format: :json

    expect(response).to be_success
  end

end

