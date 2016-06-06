class AddDoiToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :doi, :string
  end
end
