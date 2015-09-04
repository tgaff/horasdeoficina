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

user = User.find_or_create_by!(email: 'test@test.com') {|u| u.password= 'testtest'}
user2 = User.find_or_create_by!(email: 'test2@test.com') { |u| u.password= 'testtest'}
user.confirm!
user2.confirm!

c = Course.create(title: 'Rocket Science')
c2 = Course.create(title: 'Underwater Basket Weaving')
learning = Role.student
teaching = Role.educator
cp = CourseParticipant.create(role: learning, course_id: c.id, user_id: user.id)
CourseParticipant.create(role: teaching, course: c2, user: user)
13.times do |i|
  u = User.find_or_create_by!(email: "student#{i}@g.com") { |u| u.password= 'testtest' }
  CourseParticipant.create!(role: learning, course: c2, user: u)
end

WeeklyTimeBlock.create(from: time(3,'9:00'), to: time(3,'11:00'), course_participant_id: cp.id)
WeeklyTimeBlock.create(from: time(4,'12:00'), to: time(4,'13:00'), course_participant_id: cp.id)
WeeklyTimeBlock.create(from: time(2,'12:00'), to: time(2,'13:00'))
WeeklyTimeBlock.create(from: time(4,'22:00'), to: time(5,'23:00'), course_participant_id: cp.id)
