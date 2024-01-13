class Timeline < ApplicationRecord
  belongs_to :customer
  belongs_to :timelineable, polymorphic: true
end
