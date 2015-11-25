class Comment < Entry
  
  belongs_to :post 

  validates_presence_of :post

end
