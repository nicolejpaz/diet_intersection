class IngredientsController < ApplicationController
  def index
    @diets = Diet.all.map(&:name)
  end

  def create
    first = Diet.find_by_name(params["First Diet"])
    second = Diet.find_by_name(params["Second Diet"])

    first_diet = Ingredient.matching_ingredients(first).flatten
    second_diet = Ingredient.matching_ingredients(second).flatten

    @displayed_ingredients = (first_diet & second_diet)
  end
end