# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#always builds times from August 2nd
def time(day, time)
  hour = time.split(':').first.to_i
  min = time.split(':').last.to_i
  DateTime.new(2015,8,day,hour,min).in_time_zone
end

c = Course.create(title: 'Rocket Science')
Course.create(title: 'Underwater Basket Weaving')
Role.create(role_name: 'student')
Role.create(role_name: 'educator')
cp = ClassParticipant.create(role_id: Role.first.id, course_id: c.id)



WeeklyTimeBlock.create(from: time(3,'9:00'), to: time(3,'11:00'), class_participant_id: cp.id)
WeeklyTimeBlock.create(from: time(4,'12:00'), to: time(4,'13:00'), class_participant_id: cp.id)
WeeklyTimeBlock.create(from: time(2,'12:00'), to: time(2,'13:00'))
WeeklyTimeBlock.create(from: time(4,'22:00'), to: time(5,'23:00'), class_participant_id: cp.id)
