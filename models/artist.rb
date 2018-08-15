require('pg')
require_relative('../db/sql_runner.rb')
require_relative('../models/album.rb')

class Artist

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

def save()
  sql = "INSERT INTO artists (name)
  VALUES ($1)
  RETURNING id"
  values=[@name]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end


def delete()
  sql = "DELETE FROM artists WHERE id = $1"
  values=[@id]
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE artists
        SET(
          name
        ) = (
          $1
        )
        WHERE id = $2"
  values=[@name, @id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM artists"
  values=[]
  artists = SqlRunner.run(sql, values)
  return artists.map { |art| Artist.new(art)}
end

def self.delete_all()
  sql = "DELETE FROM artists"
  values=[]
  SqlRunner.run(sql, values)
end

def all_albums()
  sql = "SELECT * FROM albums
        WHERE
        artist_id = $1"
  values=[@id]
  list = SqlRunner.run(sql, values)
  return list.map { |alb| Album.new(alb)}
end

end
