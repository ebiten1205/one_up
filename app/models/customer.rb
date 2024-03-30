class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  
  # フォローをした、されたの関係
  
  #自分がフォローする（与フォロー）側の関係性
  has_many :follows, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :following_customers, through: :follows, source: :follower
  
  # 自分がフォローされる（被フォロー）側の関係性
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  
   # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :follower_customers, through: :followers, source: :follow

         
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :rts, dependent: :destroy
  has_many :timelines, dependent: :destroy
   #　フォローしたときの処理
  def follow(customer_id)
    follows.create(follower_id: customer_id)
  end
  
  #　フォローを外すときの処理
  def unfollow(customer_id)
    follows.find_by(follower_id: customer_id).destroy
  end
  
  #フォローしていればtrueを返す
  def following?(customer)
    following_customers.include?(customer)
  end
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
         
  def name
    last_name + first_name
  end
  
  # 検索方法分岐
  
  #〇〇 LIKE?に関してはSQLというデータベースから該当するものを探すようなきじゅつである（詳しくはサイトで調べた方がいい）
  # LIKE?のあとに2つ以上のものを探してもらうには以下の記述のように "or"と記述することでできる。
  #　"#{word}" + "%"　のように"%"とは値を代入する部分で、記述場所によって意味が変わるため
  #　以下の"forward_match"や"backward_match"のように後方検索なら配列の後ろに付け、前方なら前につけるなど記述場所が重要である（詳しくはサイトで調べる）
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where("first_name LIKE? or last_name LIKE?", "#{word}", "#{word}")
    elsif search == "forward_match"
      @customer = Customer.where("first_name LIKE? or last_name LIKE?", "#{word}" + "%", "#{word}" + "%")
    elsif search == "backward_match"
      @customer = Customer.where("first_name LIKE? or last_name LIKE?",  "%" + "#{word}", "%" +  "#{word}")
    elsif search == "partial_match"
      @customer = Customer.where("first_name LIKE? or last_name LIKE?",  "%" + "#{word}" + "%",  "%" + "#{word}" + "%")
    else
      @customer = Customer.all
    end
  end
  
  # is_deletedがfalseならtrueを返すようにしている
  # def active_for_authentication?
  #   super && (is_deleted == false)
  # end
end
