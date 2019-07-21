Admin::Engine.routes.draw do
  scope path: :admin do
    resources :conferences

    root to: "conferences#index"
  end

end
