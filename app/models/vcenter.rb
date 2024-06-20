class Vcenter < ApplicationRecord
  include Authorizable
  include Taxonomix

  validates :name, :fqdn, :enclave, presence: true
  scoped_search on: :name, complete_value: true
  scoped_search on: :fqdn, complete_value: true
  scoped_search on: :enclave, complete_value: true
  
  def self.fetch(params)
    list = self
      .with_counts
      .search_for(params[:search])
      .order(params[:order])
      .paginate(page: params[:page], per_page: params[:per_page])
    list
  end
  
end
  