class Post < Entry
  
  field :title, type: String
  
  embeds_many :comments

  validates_presence_of :title
  validates_uniqueness_of :title

end
