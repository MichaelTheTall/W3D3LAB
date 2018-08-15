require('pg')
require_relative('../db/sql_runner.rb')
require_relative('../models/artist.rb')


class Album
  attr_accessor :name, :artist_id, :genre
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @artist_id = options['artist_id'].to_i
    @genre = options['genre']
  end

def save()
  sql = "INSERT INTO albums
        (name, artist_id, genre)
        VALUES
        ($1, $2, $3) RETURNING id"
  values=[@name, @artist_id, @genre]
  result = SqlRunner.run(sql, values)
  @id = result[0]['id'].to_i
end

def delete()
  sql = "DELETE FROM albums WHERE id = $1"
  values=[@id]
  SqlRunner.run(sql, values)
end

def update()
  sql = "UPDATE albums
        SET(
          name, artist_id, genre
        ) = (
          $1, $2, $3
        )
        WHERE id = $4"
  values=[@name, @artist_id, @genre, @id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM albums"
  values=[]
  album_list = SqlRunner.run(sql, values)
  return album_list.map { |alb| Album.new(alb)}
end

def self.delete_all()
  sql = "DELETE FROM albums"
  values=[]
  SqlRunner.run(sql, values)
end

def artist()
  sql = "SELECT * FROM artists
        WHERE
        id = $1"
  values=[@artist_id]
  art = SqlRunner.run(sql, values)
  return art.map { |ar| Artist.new(ar)}[0]
end

def Album.find_by_id(input)
  sql = "SELECT * FROM albums
        WHERE
        id = $1"
  values=[input]
  result = SqlRunner.run(sql, values)
  if result == []
    return nil
  else
    return result.map { |alb| Album.new(alb)}
  end
end

end
