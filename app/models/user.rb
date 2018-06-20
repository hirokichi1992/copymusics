class User < ApplicationRecord
  before_save{ self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :age, presence: true, numericality: { only_integer: true }
  validates :part, presence: true
  has_secure_password
  
  #ユーザーフォロー関係
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  
  has_many :reverce_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverce_of_relationships, source: :user
  
  #ミュージックフォロー関係
  has_many :ownerships
  has_many :musics, through: :ownerships
  
  has_many :copys
  has_many :copy_musics, through: :copys, class_name: 'Music', source: :music
  
  has_many :wants
  has_many :want_musics, through: :wants, class_name: 'Music', source: :music
  
  
  #ユーザーフォロー関係
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
    #ミュージックCopy関係
  def copy(music)
    self.copys.find_or_create_by(music_id: music.id)
    self.unwant(music)
  end

  def uncopy(music)
    copy = self.copys.find_by(music_id: music.id)
    copy.destroy if copy
  end

  def copy?(music)
    self.copy_musics.include?(music)
  end
  
  #ミュージックWant関係
  def want(music)
    if !self.copys.find_by(music_id: music.id)
      self.wants.find_or_create_by(music_id: music.id)
    end
  end

  def unwant(music)
    want = self.wants.find_by(music_id: music.id)
    want.destroy if want
  end

  def want?(music)
    self.want_musics.include?(music)
  end
  
end