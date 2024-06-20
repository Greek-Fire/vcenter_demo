ForemanVcenterDemo::Engine.routes.draw do
  resources :vcenters do
    collection do
      get :auto_complete_search
    end
  end

  namespace :api do
    namespace :v2 do
      resources :vcenters
    end
  end
end

Foreman::Application.routes.draw do
  mount ForemanVcenterDemo::Engine, at: '/foreman_vcenter_demo'
end
