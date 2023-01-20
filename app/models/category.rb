class Category < ApplicationRecord
  self.table_name = "recettes_de_mos_categories"
  has_many :recipes, foreign_key: "recettes_de_mos_category_id"
end
