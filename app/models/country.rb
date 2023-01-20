class Country < ApplicationRecord
  self.table_name = "recettes_de_mos_countries"
  has_many :recipes, foreign_key: "recettes_de_mos_country_id"
end
