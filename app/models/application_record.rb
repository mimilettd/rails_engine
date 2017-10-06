class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    self.order("RANDOM()").first
  end
end
