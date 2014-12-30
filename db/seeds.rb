# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
owner = Owner.create_with_omniauth({"uid" => "123456789", "provider" => "provider of credentials for owner 123456789", 
  "info" => {"name" => "Name of owner 123456789"}})  

10.times do  
  uuid1 =  SecureRandom.uuid
  uuid2 =  SecureRandom.uuid
  
  rating = {:event_id => "#{uuid1}", :entity_id => "#{uuid2}", :username => owner.name, 
    :comment => "comment for entity #{uuid2}", :rating => rand(1..5) }  
  r = Rating.create!(rating)  
  r.owner = owner
end