class RecipesController < ApplicationController
  def index
    if params[:query].present?
      @recipes = Recipe.where("name ILIKE ?", "%#{params[:query]}%")
      @users = @recipes.map{|recipe| recipe.user}.uniq
    else
      @recipes = Recipe.all
      @users = User.all
    end

    @geojson = []
    @users.each do |user|
      recipe_list = user.recipes.map do |recipe|
        { name: recipe.name,
          description: recipe.description,
          photo: url_for(recipe.photo),
          url: "recipes/#{recipe.id}" }
      end
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [user.longitude, user.latitude]
        },
        properties: {
          title: "Les recettes de #{user.first_name} #{user.last_name}",
          description: recipe_list
        }
      }
    end

    respond_to do |format|
      format.html
      format.json { render json: @geojson } # respond with the created JSON object
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end
end
