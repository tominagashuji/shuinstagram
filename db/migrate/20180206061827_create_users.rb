class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :image

      # ピクチャーの外部キーとして追記
      t.references :picture, foreign_key: true

      t.timestamps
    end
  end
end
