require('pry-byebug')
require_relative('models/album.rb')
require_relative('models/artist.rb')
require_relative('db/sql_runner.rb')


Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({ 'name' => 'Dootman' })
artist2 = Artist.new({ 'name' => 'Bob Boberton' })
artist3 = Artist.new({ 'name' => 'BassMaster' })

artist1.save()
artist2.save()
artist3.save()


album1 = Album.new({
  'artist_id' => artist1.id,
  'name' => 'Dootman\'s Doots'
})
album2 = Album.new({
  'artist_id' => artist2.id,
  'name' => 'Send Bobs'
})

album3 = Album.new({
  'artist_id' => artist3.id,
  'name' => 'The Bass Effect Trilogy'
})

album4 = Album.new({
  'artist_id' => artist1.id,
  'name' => 'Dootman 2: Electric Dootaloo'
  })


album1.save()
album2.save()
album3.save()
album4.save()

binding.pry
nil
