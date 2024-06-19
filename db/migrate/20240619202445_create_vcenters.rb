class CreateVcenters < ActiveRecord::Migration[6.1]
    def change
      create_table :vcenters do |t|
        t.string :name, null: false
        t.string :fqdn, null: false
        t.string :enclave, null: false
  
        t.timestamps
      end
  
      add_index :vcenters, :name
      add_index :vcenters, :fqdn
    end
  end
  