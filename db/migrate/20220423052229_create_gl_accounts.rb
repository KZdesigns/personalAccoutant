class CreateGlAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :gl_accounts do |t|
      t.integer :number
      t.string :name
      t.string :type

      t.timestamps
    end
  end
end
