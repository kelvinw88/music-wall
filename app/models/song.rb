class Song < ActiveRecord::Base
  belongs_to :user
  has_many :vote_histories
  

  validates :song_title, presence: true, length: { maximum: 50}
  validates :author, presence: true, length: {maximum: 25}
  validates :url, presence:true, allow_blank: true

end
