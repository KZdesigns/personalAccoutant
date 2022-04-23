class ChangeTypeColumn < ActiveRecord::Migration[7.0]
  def change
    change_column(:gl_accounts, :type, :integer)
  end
end
