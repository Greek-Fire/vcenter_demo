module ForemanVcenterDemo
  class VcentersController < ApplicationController
      include Foreman::Controller::AutoCompleteSearch
      
      def index
        @vcenters = resource_base_search_and_page
      end

      def new
        @vcenter = Vcenter.new
      end

      def update
        if @build_report.update(build_report_params)
          process_success
        else
          process_error
        end
      end
    
      def destroy
        if @build_report.destroy
          process_success
        else
          process_error
        end
      end
  end
end