Rails.application.routes.draw do
  get 'contact/index'
  get 'timp_liber/index'
  get 'pages/home'
  get 'pages/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "about#about"
  get "pachete_si_oferte",  to: "pachete_si_oferte#index"
  get "timp_liber" , to:"timp_liber#index"
  get "contact" , to: "contact#index"
end
