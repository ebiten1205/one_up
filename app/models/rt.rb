class Rt < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  has_one :timeline, as: :timelineable, dependent: :destroy
end
