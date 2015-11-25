class Entry
  include Mongoid::Document

  # self.abstract_class = true

  field :body, type: String
  field :author, type: String
  field :created_at, type: Time
  field :updated_at, type: Time

  validates :body, :author,  presence: true, allow_blank: false

  before_create :set_created_at

  before_update :set_updated_at

  def set_created_at
  	self.created_at = Time.now
  end

  def set_updated_at
    self.updated_at = Time.now
  end

end