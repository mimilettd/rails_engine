Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get "find_all", to: "search#index"
        get "find", to: "search#show"
        get "random", to: "random#show"
        get "most_items", to: "most_items#index"
        get "/:id/invoices", to: "invoices#index"
        get "/:id/revenue", to: "revenue#show"
        get "/:id/favorite_customer", to: 'favorite_customer#show'
        get "/most_revenue", to: 'revenue#index'
        get "/revenue", to: 'total_revenue#index'
        get "/:id/customers_with_pending_invoices", to: 'customers#index'
        get "/:id/items", to: 'items#index'
      end


      namespace :invoices do
        get "find_all", to: "search#index"
        get "find", to: "search#show"
        get "random", to: "random#show"
        get "/:id/transactions", to: "transactions#index"
        get "/:id/invoice_items", to: "invoice_items#index"
        get "/:id/items", to: "items#index"
        get "/:id/merchant", to: "merchant#show"
        get "/:id/customer", to: "customer#show"
      end

      namespace :items do
        get "find_all", to: "search#index"
        get "find", to: "search#show"
        get '/most_revenue', to: 'revenue#index'
        get '/:id/invoice_items', to: 'invoice_items#index'
        get '/:id/merchant', to: 'merchant#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/best_day', to: 'best_day#index'
      end

      namespace :transactions do
        get "find_all", to: "search#index"
        get "find", to: "search#show"
        get "/:id/invoice", to: "invoice#show"
      end

      namespace :customers do
        get "find_all", to: "search#index"
        get "find", to: "search#show"
        get "/:id/invoices", to: "invoices#index"
        get "/:id/transactions", to: "transactions#index"
        get "/:id/favorite_merchant", to: "favorite_merchant#show"
      end

      namespace :invoice_items do
        get "find_all", to: "search#index"
        get "find", to: "search#show"
        get "/:id/invoice", to: "invoice#index"
        get "/:id/item", to: "item#index"
      end

      resources :invoices, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
