#json.extract! @course_calendar, :id, :weekly_time_blocks, :created_at, :updated_at
#

json.array! @wtbs.each do |wtb|
  json.start wtb.from.strftime("%Y-%m-%d %H:%M")
  json.end wtb.to.strftime("%Y-%m-%d %H:%M")
  json.course_participant_id wtb.course_participant.id
end
