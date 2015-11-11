class Post
  include Mongoid::Document
  field :title, type: String
  field :body, type: String
  field :author, type: String
  field :created_at, type: Time

  validates_uniqueness_of :title

  validates :body, presence: true, allow_blank: false
  validates :title, presence: true, allow_blank: false
  validates :author, presence: true, allow_blank: false

  before_create :set_created_at

  def set_created_at
  	self.created_at=Time.now
  end

end
