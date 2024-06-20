module ForemanVcenterDemo
  class Engine < ::Rails::Engine
    isolate_namespace ForemanVcenterDemo
    engine_name 'foreman_vcenter_demo'

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/overrides"]

    initializer 'foreman_vcenter_demo.load_app_instance_data' do |app|
      ForemanVcenterDemo::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_vcenter_demo.register_plugin', before: :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_vcenter_demo do
        requires_foreman '>= 3.7.0'
        register_gettext

        register_global_js_file 'global'

        security_block :foreman_vcenter_demo do
          permission :view_vcenters,         { :'foreman_vcenter_demo/vcenters' => %i[index auto_complete_search]}
          permission :edit_vcenters,         { :'foreman_vcenter_demo/vcenters' => %i[edit update]}
          permission :create_vcenters,       { :'foreman_vcenter_demo/vcenters' => %i[new create]}
          permission :delete_vcenters,      { :'foreman_vcenter_demo/vcenters' => [:destroy]}
        end

        role 'ForemanVcenterDemo', [:view_foreman_vcenter_demo]

        sub_menu :top_menu, :hallas_automation, caption: N_('Hallas Automation'), icon: 'pficon pficon-enterprise', after: :hosts_menu do
          menu :top_menu, :agents, caption: N_('Vcenters'), url_hash: { controller: 'foreman_vcenter_demo/vcenters', action: 'index' }, engine: ForemanVcenterDemo::Engine
        end
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanVcenterDemo::Engine.load_seed
      end
    end
  end
end
