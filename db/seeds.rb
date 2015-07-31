# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(role_name: 'student')
Role.create(role_name: 'educator')
cp = ClassParticipant.create(role_id: Role.first.id)

WeeklyTimeBlock.create(dotw: 'Sunday', from: '9:00', to: '11:00', class_participant_id: cp.id)
WeeklyTimeBlock.create(dotw: 'Sunday', from: '12:00', to: '13:00', class_participant_id: cp.id)
WeeklyTimeBlock.create(dotw: 'Tuesday', from: '12:00', to: '13:00')
WeeklyTimeBlock.create(dotw: 'Wednesday', from: '22:00', to: '23:00', class_participant_id: cp.id)
