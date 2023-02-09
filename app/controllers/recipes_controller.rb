class RecipesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @recipes = Recipe.where("name ILIKE ?", "%#{params[:query]}%")
      @users = @recipes.map{|recipe| recipe.user}.uniq
    else
      @recipes = Recipe.all
      @users = User.all
    end

    @geojson = []
    @users.geocoded.each do |user|
      recipe_list = user.recipes.map do |recipe|
        { name: recipe.name,
          description: recipe.description,
          photo: url_for(recipe.photo.attached? ? recipe.photo : "https://3.bp.blogspot.com/-nYA0bHCYhwU/U4K3jCjis0I/AAAAAAAAAEk/KcvLAZa_SJA/s1600/healthy-food-stocks.jpeg"),
          url: "recipes/#{recipe.id}" }
      end
      @geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [user.longitude + (rand(10)-5)*0.001, user.latitude + (rand(10)-5)*0.001]
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
    @recipe.ingredient = ["","",""]
    @recipe.prep_step = ["","",""]
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    @recipe.save
    redirect_to recipe_path(@recipe)
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :photo, :prep_time, :cook_time, :guests_amount, :country_id, :category_id, prep_step: [], ingredient: [])
  end
end
