class AddHiddenFlagToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :hidden, :boolean
  end
end
