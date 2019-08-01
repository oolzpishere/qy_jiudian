Admin::Engine.routes.draw do
  scope path: :admin do
    resources :conferences

    root to: "conferences#index"
  end

  devise_for :users, module: 'devise', class_name: "Account::User"

end
