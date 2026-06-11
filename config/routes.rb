Rails.application.routes.draw do
  get    "/admin",        to: "admin/sessions#new",     as: :admin_login
  post   "/admin",        to: "admin/sessions#create"
  delete "/admin/logout", to: "admin/sessions#destroy", as: :admin_logout
  
  namespace :admin do
    resources :blog_posts do
      patch :toggle_publish, on: :member
    end
  end

  get "blog", to: "blog#index", as: :blog
  get "blog/:slug", to: "blog#show", as: :blog_post
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
  get "oferte", to: "oferte#index"
  get "proceduri", to: "proceduri#index"
  get "/facilitati", to: "facilitati#index"
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
