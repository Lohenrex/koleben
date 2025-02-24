class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  # Validations
  validates :name, presence: true
  validates :apartment_number, presence: true, unless: -> { role == :gatekeeper }
  validates :role, presence: true
  has_many :issues, dependent: :destroy

  # Enums
  enum :role, { admin: 0, manager: 1, resident: 2, gatekeeper: 3 }
end
