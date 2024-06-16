class AddAcceptedToFollows < ActiveRecord::Migration[7.1]
  def change
    add_column :follows, :accepted, :boolean
  end
end
