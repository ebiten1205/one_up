class Notification < ApplicationRecord
  belongs_to :notificatable, polymorphic: true
end
