Foodgenie::Application.routes.draw do

  # Forms
  resources :blender_forms
  resources :genie_search_forms

  # Data 
  resources :ingredients
  resources :categories
  resources :recipes
  resources :food_items, :collection => {:formatted => [:get, :post]}

  # Default root
  root to: 'genie_search_forms#new'  

end
