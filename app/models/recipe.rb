class Recipe < ApplicationRecord
  belongs_to :country
  belongs_to :category
  belongs_to :user
end
