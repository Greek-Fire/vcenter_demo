module ForemanVcenterDemo
  class VcentersController < ApplicationController
    include Foreman::Controller::Parameters::Vcenter
    include Foreman::Controller::AutoCompleteSearch
    
    before_action :find_vcenter, only: [:edit, :update, :destroy, :show]

    def index
      @vcenters = Vcenter.fetch(params)
    end

    def new
      @vcenter = Vcenter.new
    end

    def create
      @vcenter = Vcenter.new(vcenter_params)
      if @vcenter.save
        process_success
      else
        process_error
      end
    end

    def update
      if @vcenter.update(vcenter_params)
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

    private

    def find_vcenter
      @vcenter = Vcenter.find(params[:id])
    end

    def vcenter_params
      params.require(:vcenter).permit(:name, :fqdn, :enclave, location_ids: [], organization_ids: [])
    end
  end
end
