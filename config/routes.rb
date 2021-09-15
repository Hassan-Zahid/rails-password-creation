Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => 'homepage#index'

  post '/upload_csv' => 'homepage#upload_csv', as: :upload_csv
end
