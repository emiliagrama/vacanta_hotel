Rails.application.routes.draw do
  
  get 'hidden_pages/termeni_si_conditii'
  get 'hidden_pages/politica_confidentialitate'
  get 'hidden_pages/politica_cookies'
  get 'newsletters/create'
  get 'despre/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "about#about"
  get "despre", to: "despre#index"
  get "pachete_si_oferte",  to: "pachete_si_oferte#index"
  get "tratamente_si_facilitati", to: "tratamente_si_facilitati#index"
  get "restaurant_conferinte_si_terasa", to: "restaurant_conferinte_si_terasa#index"
  get "timp_liber" , to:"timp_liber#index"
  get "ozonoterapie", to: "ozonoterapie#show", as: :ozonoterapie


  # Contact form
  get "contact",          to: "contact#new",     as: :contact
  post "contact",         to: "contact#create"
  get "contact/thank_you",to: "contact#thank_you", as: :contact_thank_you
  resources :newsletters, only: [:create]

  get 'termeni_si_conditii', to: 'hidden_pages#termeni_si_conditii'
  get 'politica_confidentialitate', to: 'hidden_pages#politica_confidentialitate'
  get 'politica_cookies', to: 'hidden_pages#politica_cookies'
end
