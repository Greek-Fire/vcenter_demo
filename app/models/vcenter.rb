class Vcenter < ApplicationRecord
  include Authorizable
  include Taxonomix

  #validates :name, :fqdn, :enclave, presence: true
  scoped_search on: :name, complete_value: true
  scoped_search on: :fqdn, complete_value: true
  scoped_search on: :enclave, complete_value: true
  
end
