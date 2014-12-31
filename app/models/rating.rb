class Rating < ActiveRecord::Base
  belongs_to :owner
  validates :entity_id, :rating, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  
  default_scope { order('updated_at DESC') }
  paginates_per 15
  
  def self.last_n_comments(entity_id, n=10)
    if (!n.is_a? Numeric) 
      n = 10
    else
      n = n.ceil.abs
    end
    last10 = Rating.where("entity_id = ?", entity_id).limit(n).order('id desc')
    ret10 = []
    last10.each do |rating|      
      ret10 = ret10 << {username: rating.username, comment: rating.comment, rating: rating.rating}
    end
    return ret10
  end
  
  def self.caculated_rating(entity_id)
    calcRatings = 0
    nrRatings = 0
    Rating.where("entity_id = ?", entity_id).each do |rating|
      calcRatings = calcRatings + rating.rating
      nrRatings = nrRatings + 1
    end
    if nrRatings == 0
      return 0
    else
      return calcRatings/nrRatings
    end
  end
end
