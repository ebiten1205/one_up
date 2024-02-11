class Timeline < ApplicationRecord
  belongs_to :customer
  belongs_to :timelineable, optional: true, polymorphic: true
  
  ##has_many :posts, dependent: :destroy
end
