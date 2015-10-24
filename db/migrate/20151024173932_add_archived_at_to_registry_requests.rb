class AddArchivedAtToRegistryRequests < ActiveRecord::Migration
  def change
    add_column :registry_requests, :archived_at, :datetime
  end
end
