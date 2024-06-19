ForemanVcenterDemo::Engine.routes.draw do
  resources :vcenters do
    get :auto_complete_search, on: :collection
  end

  namespace :api do
    namespace :v2 do
      resources :vcenters
    end
  end
end

Foreman::Application.routes.draw do
  mount ForemanPluginTemplate::Engine, at: '/foreman_vcenter_demo'
end
