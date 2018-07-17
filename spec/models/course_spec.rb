require 'rails_helper'

RSpec.describe Course, :type => :model do
  it "is valid with valid attributes"
  it "is not valid without a name"
  it "is not valid without a start_date"
  it "is not valid without a duration"
  it "is not valid without a category"
  it "is not valid without a difficulty"
end
