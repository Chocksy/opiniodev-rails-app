class Idea
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :created_at, type: Time
  field :user, type: String
end
