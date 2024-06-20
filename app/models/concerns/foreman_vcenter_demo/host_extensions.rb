# app/models/vcenter/host_extensions.rb
module Vcenter
    module HostExtensions
      extend ActiveSupport::Concern
  
      included do
        # Define your extensions here
      end
  
      class_methods do
        # Define class methods here
      end
    end
  end
  
  # In your engine configuration, include the module
  config.to_prepare do
    begin
      Host::Managed.send(:include, Vcenter::HostExtensions)
      HostsHelper.send(:include, Vcenter::HostsHelperExtensions)
    rescue => e
      Rails.logger.warn "Vcenter: skipping engine hook (#{e})"
    end
  end
  