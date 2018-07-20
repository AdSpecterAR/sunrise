require 'rails_helper'

RSpec.describe Course, :type => :model do
  let(:instructor) { create(:user, :instructor) }
  let(:course) { create(:course, instructor: instructor) }

  describe 'validations' do
    it "is valid with valid attributes" do
      expect(course).to be_valid
    end

    it "is not valid without a name" do
      course.update(name: nil)

      expect(course).not_to be_valid
    end

    it "is not valid without a duration" do
      course.update(duration: nil)

      expect(course).not_to be_valid
    end


    it "is not valid without a valid category" do
      course.update(category: 'medium')

      expect(course).not_to be_valid
    end

    it "is not valid without a valid difficulty" do
      course.update(difficulty: 'yoga')

      expect(course).not_to be_valid
    end

    it "must have an instructor" do

    end

    describe 'associations' do

    end
  end
end
