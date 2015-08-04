FactoryGirl.define do
  factory :weekly_time_block do
    dotw "Sunday"
    from "15:00"
    to "17:00"
    can false
    preferred 1
    class_participant nil
  end

end
