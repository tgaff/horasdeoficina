json.array! @course_participants.each do |cp|
  json.id cp.id
  json.email cp.user.email
  json.role cp.role.role_name
end
