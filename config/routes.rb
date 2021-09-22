Rails.application.routes.draw do
  get 'input', to: 'valuation#input'
  get 'answer', to: 'valuation#answer'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
