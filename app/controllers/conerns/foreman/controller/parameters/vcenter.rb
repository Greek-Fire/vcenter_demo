module Foreman::Controller::Parameters::BuildReport
    extend ActiveSupport::Concern
  
    class_methods do
      def vcenter_params_filter
        Foreman::ParameterFilter.new(::Vcenter).tap do |filter|
          filter.permit :name, :fqdn, :enclave, :location_ids => [], :organization_ids => []
        end
      end
    end
  
    def vcenter_params
      self.class.vcenter_params_filter.filter_params(params, parameter_filter_context)
    end
  end