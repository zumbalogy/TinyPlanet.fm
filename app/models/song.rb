class Song < ActiveRecord::Base
  has_many :users, though: :opinions
  # attr_accessible :title, :body
end
