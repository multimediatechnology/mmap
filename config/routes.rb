Rails.application.routes.draw do
  scope "/bewerbung/projekt-upload" do
    resources :settings
    devise_for :users, :controllers => {registrations: 'registrations'}

    resources :users, only: [:index, :show, :edit, :update] do
      resources :assets
      get 'reopen', to: 'users#reopen'
    end

    resources :majors
    resources :settings

    get 'admin', to: 'admin#home'
    get 'admin/download', to: 'admin#download'

    root to: 'pages#home'
  end
end
