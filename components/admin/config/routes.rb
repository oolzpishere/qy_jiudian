Admin::Engine.routes.draw do
  scope path: "/admin", module: "admin" do
    resources :conferences
    resources :hotels
    resources :orders

    root to: "conferences#index", :as => :admin_root
  end

  scope path: "/user", module: "user" do
    resources :orders
    root to: "orders#index", :as => :user_root
  end

  # namespace :user do
  #
  #     resources :orders
  #     # root to: "conferences#index"
  #
  # end


  devise_for :users,  module: 'devise', class_name: "Account::User"
  devise_for :admins, module: 'devise', class_name: "Account::Admin"

  get "/auth/wechat/callback" => "authentications#wechat"

  # get "/auth/:action/callback", :controller => "authentications", :constraints => { :action => /wechat|google/ }
end
