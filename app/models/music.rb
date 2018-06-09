class Music < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  
  has_many :ownerships
  has_many :users, through: :ownerships
  
  has_many :copys, class_name: 'Copy'
  has_many :copy_users, through: :copys, class_name:'User', source: :user
  
  has_many :wants
  has_many :want_users, through: :wants, class_name:'User', source: :user
end
