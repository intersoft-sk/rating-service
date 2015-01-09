require 'active_resource'

class Relationship < ActiveResource::Base 
  self.site = "http://entity-manager.herokuapp.com/" #"http://localhost:3001/"
  self.format = :xml
end