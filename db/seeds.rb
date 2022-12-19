if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(
    name: 'Sample',
    redirect_uri: '',
    scopes: ''
  )
end

def create_users
  return if User.count > 1

  (1..5).each do |_|
    User.create!(
      email: Faker::Internet.email,
      password: Faker::Internet.password
    )
  end
end

def create_categories
  return if Category.count > 1

  (1..5).each do |_|
    Category.create!(
      description: Faker::Lorem.sentence(word_count: rand(20..30)).chomp('.')
    )
  end
end

def available_unit
  %w[cup teaspoons gram kilogram]
end

def available_difficulty
  %w[easy normal challenging]
end

def create_ingredient(recipe_id)
  Ingredient.create!(
    recipe_id: recipe_id,
    unit: available_unit.sample,
    amount: Faker::Number.between(from: 0.5, to: 3.0).round(1)
  )
end

def create_recipes
  return if Recipe.count > 1

  user_id_list = User.all.pluck(:id)
  category_id_list = Category.all.pluck(:id)

  user_id_list.each do |_|
    user_id = user_id_list.sample
    category_id = category_id_list.sample
    recipe = Recipe.create!(
      descriptions: Faker::Lorem.sentence(word_count: rand(20..30)).chomp('.'),
      title: Faker::Lorem.sentence(word_count: rand(5..10)).chomp('.'),
      user_id: user_id,
      category_id: category_id,
      difficulty: available_difficulty.sample,
      time: Faker::Number.number(digits: 2)
    )
    (1..2).each do |_|
      create_ingredient(recipe.id)
    end
    user_id_list -= [user_id]
    category_id_list -= [category_id]
  end

end

create_users
create_categories
create_recipes
