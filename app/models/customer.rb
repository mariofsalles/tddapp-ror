class Customer < ApplicationRecord
  validates :name, :email, :phone, :smoker, presence: true
end
