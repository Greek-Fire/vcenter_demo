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

        # Add Global files for extending foreman-core components and routes
        register_global_js_file 'global'

        # Add permissions
        security_block :foreman_vcenter_demo do
          permission :view_vcenters, { :vcenters => %i[index auto_complete_search]},
                     :resource_type => 'BuildReport'
          permission :edit_vcenters, { :vcenters => %i[edit update]},
                     :resource_type => 'BuildReport'
          permission :create_vcenters, { :BuildReport => %i[new create]},
                     :resource_type => 'BuildReport'
          permission :destroy_vcenters_, { :vcenters => [:destroy]},
                     :resource_type => 'BuildReport'
        end

        # Add a new role called 'Discovery' if it doesn't exist
        role 'ForemanVcenterDemo', [:view_foreman_vcenter_demo]

        # Add menu entry

        sub_menu :top_menu, :hallas_automation, caption: N_('Hallas Automation'), icon: 'pficon pficon-enterprise', after: :hosts_menu do
          menu :top_menu, :agents, caption: N_('Vcenters'), url_hash: { controller: 'foreman_vcenter_demo/vcenters', action: 'index' }, engine: ForemanVcenterDemo::Engine
        end

        # Add dashboard widget (if needed)
        # widget 'foreman_vcenter_demo_widget', name: N_('Foreman plugin template widget'), sizex: 4, sizey: 1
      end
    end

    rake_tasks do
      Rake::Task['db:seed'].enhance do
        ForemanVcenterDemo::Engine.load_seed
      end
    end
  end
end
