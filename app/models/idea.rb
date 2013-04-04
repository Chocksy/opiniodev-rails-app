class Idea
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Pagination
  field :title, type: String
  field :description, type: String

  belongs_to :user
  accepts_nested_attributes_for :user

end
