class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :name, type: String
  field :password, type: String

  has_many :ideas, :dependent => :delete
end
