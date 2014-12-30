class Rating < ActiveRecord::Base
  belongs_to :owner
  
  default_scope { order('updated_at DESC') }
  paginates_per 15
end
