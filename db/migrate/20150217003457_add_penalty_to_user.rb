class AddPenaltyToUser < ActiveRecord::Migration
  def change
    add_column :users, :penalty, :boolean
  end
end
