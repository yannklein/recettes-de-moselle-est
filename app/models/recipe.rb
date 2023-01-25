class Recipe < ApplicationRecord
  self.table_name = "recettes_de_mos_recipes"
  belongs_to :country, foreign_key: "recettes_de_mos_country_id"
  belongs_to :category, foreign_key: "recettes_de_mos_category_id"
  belongs_to :user
  # has_one_attached :photo
  def photo
    attachement = ActiveStorage::Attachment.find_by(name: :photo, record_type: 'RecettesDeMosRecipe', record_id: self.id)
    attachement.define_singleton_method(:attached?) { !!attachement.key }
    attachement
  end
end
