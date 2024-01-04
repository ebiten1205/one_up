class Customer < ApplicationRecord
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :post, dependent: :destroy
         
  def name
    last_name + first_name
  end
  
  def self.search_for(content, search)
    if search == 'perfect'
      Customer.where(name: content)
    elsif search == 'forward'
      Customer.where('name LIKE ?', content + '%')
    elsif search == 'backward'
      Customer.where('name LIKE ?', '%' + content)
    else
      Customer.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end
end
