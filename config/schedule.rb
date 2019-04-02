# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end

every 1.day, at: ['4:30 am'] do
  runner "Streak.close_expired_streaks"
end


# def self.run_safely(name)
#   ApplicationRecord.connection_pool.with_connection do
#     begin
#       Rails.logger.info "Starting #{name}"
#       yield
#     rescue => e
#       Raven.capture_exception(e, extra: {job_name: name})
#     ensure
#       Rails.logger.info "Finished #{name}"
#     end
#   end
# end

# Learn more: http://github.com/javan/whenever
