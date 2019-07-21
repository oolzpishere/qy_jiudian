Rails.application.routes.draw do

  mount Admin::Engine => '/', as: 'admin'
end
