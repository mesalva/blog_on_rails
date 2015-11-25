class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :description, type: String

  validates_uniqueness_of :email
  validates_presence_of :name, :email, :password
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, length: { minimum: 6 }

  before_create :hash_password

  def hash_password
  	self.password = Digest::SHA1.hexdigest(self.password)
  end
end
