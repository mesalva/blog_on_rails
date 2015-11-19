class Entry
  include Mongoid::Document

  # self.abstract_class = true

  field :body, type: String
  field :author, type: String
  field :created_at, type: Time

  validates :body, presence: true, allow_blank: false
  validates :author, presence: true, allow_blank: false

  before_create :set_created_at

  def set_created_at
  	self.created_at = Time.now
  end

end