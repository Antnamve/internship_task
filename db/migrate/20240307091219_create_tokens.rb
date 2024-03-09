class CreateTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :tokens do |t|
      t.references :student, null: false, foreign_key: true
      t.text :token, null: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
