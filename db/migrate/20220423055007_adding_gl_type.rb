class AddingGlType < ActiveRecord::Migration[7.0]
  def change
    add_column :gl_accounts, :gl_type, :string
  end
end
