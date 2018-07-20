require 'rails_helper'

describe CourseSessionController, type: :controller do

  let(:instructor) { create(:user, :instructor) }
  let(:course) { create(:course, instructor: instructor) }
  let(:course_session1) { create(:course_session, course: course, start_time: Time.now) }
  let(:course_session2) { create(:course_session, course: course, start_time: 1.hour.ago) }
  let(:course_session3) { create(:course_session, course: course, start_time: 2.hours.from) }
  let(:course_session4) { create(:course_session, course: course, start_time: 4.hours.ago) }

  it "returns the right properties as JSON"
  it "returns sessions that are within 24 hours" do

  end
  it "returns sessions sorted"
end