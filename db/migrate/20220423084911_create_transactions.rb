class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.date :date
      t.integer :amount
      t.string :notes
      t.text :description
      t.references :gl_account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
