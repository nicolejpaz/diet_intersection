class Ingredient < ActiveRecord::Base
  belongs_to :diet

  def create
    Ingredient.create(ingredient_params)
  end

  def self.find_diets(user_searched, matched)
    if Ingredient.exists?(:diet_id => user_searched.id)
      search_ingredients(user_searched, matched)
    else
      new_ingredients = Yummly::Api.search('', {'allowedDiet' => "#{user_searched.meta_number}^#{user_searched.name}"})

      find_new_ingredients(new_ingredients, matched, user_searched)
    end
    matched
  end

  def self.find_allergies(user_searched, matched)
    if Ingredient.exists?(:diet_id => user_searched.id)
      search_ingredients(user_searched, matched)
    else
      new_ingredients = Yummly::Api.search('', {'allowedAllergy' => "#{user_searched.meta_number}^#{user_searched.name}"})

      find_new_ingredients(new_ingredients, matched, user_searched)
    end
    matched
  end

  def self.search_ingredients(user_searched, matched)
    Ingredient.where(:diet_id == user_searched.id).each do |ingredient|
      matched << ingredient.name
    end
  end

  def self.find_new_ingredients(new_ingredients, matched, user_searched)
    new_ingredients.each do |diet|
      matched << diet.ingredients
    end
    matched.each do |ingredient_name|
      ingredient_name.each do |name|
        Ingredient.create(name: name, diet_id: user_searched.id)
      end
    end
  end

  def self.matching_ingredients(user_searched)
    matching_ingredients = []
    
    if user_searched.diet_type == 'diet'
      find_diets(user_searched, matching_ingredients)
    elsif user_searched.diet_type == 'allergy'
      find_allergies(user_searched, matching_ingredients)
    end
  end

  private
  def ingredient_params
    params.require(:ingredient).permit(:name, :diet_id)
  end 
end