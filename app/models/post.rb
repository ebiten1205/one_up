class Post < ApplicationRecord
  has_one_attached :image
  has_many :genres, dependent: :destroy
  belongs_to :customer
  
  def self.search_for(content, search)
    if search == 'perfect'
      Post.where(content: content)
    elsif search == 'forward'
      Post.where('content LIKE ?', content+'%')
    elsif search == 'backward'
      Post.where('content LIKE ?', '%'+content)
    else
      Post.where('content LIKE ?', '%'+content+'%')
    end
  end
  
end
