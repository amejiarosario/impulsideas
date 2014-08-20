Impulsideas::Application.routes.draw do
  post 'ipn_notifications/:contribution_id',
    to: 'payment_notifications#create',
    as: 'ipn_notifications'

  get 'contact_form/new'
  get 'contact_form/create'
  get 'about/faq'
  get 'about/faq_en'
  get 'about/index'
  get 'about/main'
  get 'about/terms'
  get 'about/terms_en'
  get 'about/landing'
  get 'about', to: 'about#index', as: 'about'

  resources :contact_form, only: :create
  resources :payment_notifications

  mount RedactorRails::Engine => '/redactor_rails'

  resources :projects do
    resources :items, shallow: true
    get 'orders', on: :member
  end

  resources :orders, except: [:update, :destroy, :new, :edit] do
    get 'execute', on: :member
    get 'event/:event' => 'orders#event', on: :member, as: 'event'
  end

  get 'items', to: 'items#index', as: 'items'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'registrations'
  }

  root 'about#main'
end
