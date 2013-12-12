DietIntersection::Application.routes.draw do
  root :to => 'ingredients#index'
  resources :ingredients
end
