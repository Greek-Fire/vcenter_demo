module ForemanVcenterDemo
  class VcentersController < ApplicationController
      include Foreman::Controller::Parameters::Vcenter
      include Foreman::Controller::AutoCompleteSearch
      
      def index
        @vcenters = resource_base_search_and_page.all
      end

      def new
        @vcenter = Vcenter.new
      end

      def update
        if @vcenter.update(vcenter_params)
          process_success
        else
          process_error
        end
      end

      def create
        @vcenter = Vcenter.new(vcenter_params)
    
        if @vcenter.save
          process_success
        else
          process_error
        end
      end
    
      def destroy
        if @vcenter.destroy
          process_success
        else
          process_error
        end
      end

      def edit; end
      def show; end
  end
end