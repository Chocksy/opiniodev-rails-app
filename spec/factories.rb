FactoryGirl.define do
  factory :user do
    provider "twitter"
    sequence(:email) {|n| "person-#{n}@example.com" }
    sequence(:name) {|n| "Person #{n}"}
    uid '12345'
  end

  factory :idea do
    sequence(:title) {|n| "Idea #{n}"}
    sequence(:description) {|n| "Description #{n}"}
    created_at 4.days.ago
    association :user_id, :factory => :user
  end

end