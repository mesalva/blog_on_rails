class Post < Entry
  
  field :title, type: String
  
  has_many :comments, :dependent => :destroy

  validates_presence_of :title
  validates_uniqueness_of :title

end
