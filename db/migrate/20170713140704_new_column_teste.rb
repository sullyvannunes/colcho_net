class NewColumnTeste < ActiveRecord::Migration[5.1]
  def change
    create_table :teste_de_conceito do |t|
      t.string :title
      t.string :email
    end
  end
end
