class Song < ActiveRecord::Base
  validates :song_title, presence: true, length: { maximum: 50}
  validates :author, presence: true, length: {maximum: 25}
  validates :url, presence:true, allow_blank: true
end
