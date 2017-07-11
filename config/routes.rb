Rails.application.routes.draw do
  LOCALES = /en|pt\-BR/

  scope ':locale', :locale => LOCALES do
    resources :rooms
    resources :users

    resource :user_confirmation, :only => [:show]
  end

  # match '/:locale' => 'home#index'#, :locale => LOCALES, via: 'get'
  root :to => "home#index"
 # match :users/:id/teste => 'users#teste', via: 'get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
