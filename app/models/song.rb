class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.create(name: name)
  end

  def artist_name
    self.artist.name if self.artist
  end
end
