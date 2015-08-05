FactoryGirl.define do
  factory :weekly_time_block do
    from DateTime.new(2015,8,2,15,00)
    to DateTime.new(2015,8,2,17,00)
    can false
    preferred 1
    class_participant nil
  end
end
