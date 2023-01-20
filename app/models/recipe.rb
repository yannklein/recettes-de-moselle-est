class Recipe < ApplicationRecord
  self.table_name = "recettes_de_mos_recipes"
  belongs_to :country, foreign_key: "recettes_de_mos_country_id"
  belongs_to :category, foreign_key: "recettes_de_mos_category_id"
  belongs_to :user
  has_one_attached :photo
end
