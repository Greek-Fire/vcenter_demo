module ForemanVcenterDemo
    class VcentersController < ApplicationController
      include Foreman::Controller::AutoCompleteSearch
      
      def index
        @vcenters = resource_base_search_and_page
      end
      def new
        @vcenters = Vcener.new
      end
    end
  end
  