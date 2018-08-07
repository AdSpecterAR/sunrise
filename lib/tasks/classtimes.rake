desc "push class times forward by one day (to classes 4, 5, 6, 7"
task :update_class_times, [:course_session_id]  => :environment do |t, args|
  course_session_id = args[:course_session_id]
  old_time = CourseSession.find(course_session_id).start_time
  CourseSession.find(course_session_id).update(start_time: old_time + 1.day)
end
