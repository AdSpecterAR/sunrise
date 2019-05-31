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
    self.user.viewed_posture_courses.select do |v|
      if v.posture_course.track_id.present?
        v.posture_course.track.id == self.track.id
      end
    end
  end

  def completed_courses
    self.user.viewed_posture_courses.select do |v|
      if v.posture_course.track_id.present?
        v.posture_course.track_id == self.track_id && v.completed
      end
    end

    # self.user.viewed_posture_courses.completed # has to match track ID
  end

  def last_completed_course_number
    return 0 if completed_courses.empty?

    posture_courses = completed_courses.map{|a| a.posture_course}
    last_completed_course_number = posture_courses.max_by(&:order_in_track).order_in_track

    return 0 if last_completed_course_number.nil?

    last_completed_course_number
  end
end