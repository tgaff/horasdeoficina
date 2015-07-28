FactoryGirl.define do
  factory :user do
    email "g@g.com"
    password "12345678"
    confirmed_at { Time.now }

    factory :unconfirmed_user do
      confirmed_at nil
    end
  end
end
