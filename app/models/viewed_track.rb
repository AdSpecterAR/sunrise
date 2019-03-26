class ViewedTrack < ApplicationRecord

  ### INCLUDES ###

  ### CONSTANTS ###


  ### ASSOCIATIONS ###

  belongs_to :user
  belongs_to :track


  ### SCOPES ###


  ### VALIDATIONS ###


  ### CALLBACKS ###


  ### CLASS METHODS ###


  def viewed_courses
    result = self.user.viewed_posture_courses.select do |v|
      v.posture_course.track.id == self.track.id
    end

    puts 'hi'

    result
  end

  def completed_courses
    viewed_courses.select { |a| a.completed }
  end

  def last_completed_course_number
    return 0 if completed_courses.empty?

    posture_courses = completed_courses.map{|a| a.posture_course}
    last_completed_course_number = posture_courses.max_by(&:order_in_track).order_in_track

    if last_completed_course_number.nil?
      return 0
    end

    last_completed_course_number
  end
end