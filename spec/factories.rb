FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "person-#{n}@example.com" }
    password "secretrazvan"
    trait(:admin)  { admin  true }
  end

  factory :idea do
    sequence(:title) {|n| "Idea #{n}"}
    sequence(:description) {|n| "Description #{n}"}
    created_at 4.days.ago
  end

end