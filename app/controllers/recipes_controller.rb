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
          title: "Recettes de #{user.first_name} #{user.last_name}",
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
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.save
    redirect_to recipe_path(@recipe)
  end

  def edit
  end

  def update
    @recipe = Recipe.update(recipe_params)
    @recipe.save
    redirect_to recipe_path(@recipe)
  end

  def delete
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :photo, :prep_time, :prep_step, :cook_time, :ingredient, :guests_amount, :country_id, :category_id)
  end
end
