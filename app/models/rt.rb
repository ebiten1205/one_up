class Rt < ApplicationRecord
  belongs_to :customer
  belongs_to :post
  
  has_one :timeline, as: :timelineable_type, dependent: :destroy
end
