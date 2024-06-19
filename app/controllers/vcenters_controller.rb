module ForemanVcenterDemo
    class VcentersController < ApplicationController
      include Foreman::Controller::AutoCompleteSearch
      
      def index
        @vcenters = resource_base_search_and_page
      end
      def new
        @vcenter = Vcenter.new
      end
  
      def create
        @vcenter = Vcenter.new(vcenter_params)
        if @vcenter.save
          redirect_to vcenters_path, notice: 'Vcenter was successfully created.'
        else
          render :new
        end
      end
  
      private
  
      def vcenter_params
        params.require(:vcenter).permit(:name, :fqdn, :enclave)
      end
    end
  end