class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :name, presence: true, length: { minimum: 1 }
  validates :apartment_number, presence: true
  validates :is_owner, inclusion: { in: [ true, false ], message: "must be true or false" }
  validates :phone_number, presence: true
  validates :email_address, presence: true, uniqueness: true
end
