require 'faker'
require "open-uri"

# Destroy former seeds
puts "Destroy all seeds..."
Recipe.destroy_all
Country.destroy_all
Category.destroy_all
User.destroy_all
puts "destroyed!"

# Create users
puts "User creation..."
file = URI.open('https://avatars2.githubusercontent.com/u/26819547?s=400&u=ae79d8825ad1127723641cbf32a9a7e2ec221e7f&v=4')
yann = User.new(first_name: 'Yann', last_name: 'Klein', password: '123456', email: 'yann@gmail.com', location:"Théding")
yann.photo.attach(io: file, filename: 'yann.jpg', content_type: 'image/jpg')
yann.save

3.times do |id|
  file = URI.open('https://i.pravatar.cc/300')
  user = User.new(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name , password: '123456', email: "user#{id}@gmail.com", location:["Sarreguemines", "Forbach", "Bitche"].sample)
  user.photo.attach(io: file, filename: "avatar#{id}.jpg", content_type: 'image/jpg')
  user.save
end

# Create countries
puts "Country creation..."
Country.create!(name: 'Vallée de la Sarre', description: 'La vallée de la Sarre est un important bassin d’emplois regroupant les zones industrielles de Sarreguemines, Hambach et Sarralbe.')
bassin_houiller = Country.create!(name: 'Le bassin Houiller', description: 'L\'ancien bassin houiller se concentre essentiellement dans la dépression du Warndt, une forme de semi-boutonnière regardant vers le Land de Sarre.')
Country.create!(name: 'Pays de Nied', description: 'Le Pays de Nied est le plateau lorrain allant de Bouzonville à Morhange, entre la Nied au sud et le Warndt au nord. ')
Country.create!(name: 'Pays des Lacs', description: 'Le Pays des Lacs entre l’ancien bassin houiller et le Pays de Bitche très vallonné, conjugue un développement entre élevage, forêts et étangs. ')
Country.create!(name: 'Pays de Bitche', description: 'Le Pays de Bitche est formé d’un isthme au nord-est du département. Sa partie orientale très boisée a une vocation forestière et touristique tandis que la partie occidentale conserve un paysage agricole')
Country.create!(name: 'Vosges du Nord', description: 'Le Parc naturel régional des Vosges du Nord se situe à cheval sur le département de la Moselle et le Bas-Rhin.')

# Create category
puts "Category creation..."
Category.create!(name: 'Entrée', description: '')
Category.create!(name: 'Apéritif', description: '')
plat_principal = Category.create!(name: 'Plat principal', description: '')
Category.create!(name: 'Dessert', description: '')
Category.create!(name: 'Boisson', description: '')

# Create recipes
puts "Recipe creation..."
file = URI.open('https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimages.ctfassets.net%2F3s5io6mnxfqz%2F1NkSmY3QsqKr7DQ2cleBbT%2F0f514614ffd98ac6a39eefe2e6ff85a2%2FAdobeStock_179730200.jpeg&f=1&nofb=1')
recipe = Recipe.new(
  name: 'Knepp et pomme de terres à la crème',
  description: 'La recette de Knepp de ma mamie, un gout dont je me souviendrai toujours.',
  country: bassin_houiller,
  category: plat_principal,
  user: yann,
  ingredient: [{'Farine': "400g",
                'Oeufs': "2",
                'Eau': "1/2 litre",
                'Poivre': "",
                'Sel': "",
                'Lardons': "250g",
                'Crème fraîche épaisse': "250g",
                'Persil': '',
                'Oignon': '1'
              }],
  prep_time: 5,
  cook_time: 20,
  prep_step: [
              "Prendre un saladier, y verser la farine, ajouter les oeufs puis le sel et le poivre. Ajouter l'eau petit à petit jusqu'à ce que la pâte soit élastique.",
              "Faire bouillir votre eau (salée) dans une grande casserole.",
              "A ébullition, former de petits kneppe avec 2 petites cuillères (de la taille que l'on veut) et les plonger dans l'eau bouillante.",
              "ils sont cuits dès lros qu'ils remontent tous à la surface (ce qui prend plus ou moins 5 minutes, selon leur taille). Les mettre de côté.",
              "Pour la sauce, couper l'oignon en petits dés, puis le faire revenir dans un petit peu de matière grasse. Ajouter les oignons, puis la crème, puis laisser chauffer la sauce afin quelle devienne un peu épaisse."
            ],
  guests_amount: 2
)
recipe.photo.attach(io: file, filename: 'recipe.jpg', content_type: 'image/jpg')
recipe.save
puts "Seeded!"

