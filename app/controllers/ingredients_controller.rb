class IngredientsController < ApplicationController
  def index
    @diets = Diet.all.map(&:name)
  end

  def create
    p params
    @first_diet = Diet.find_by_name(params["First Diet"])
    @second_diet = Diet.find_by_name(params["Second Diet"])
    p @first_diet
    p @second_diet
  end
end