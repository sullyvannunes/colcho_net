class DropNewColumnTeste < ActiveRecord::Migration[5.1]
  def change
    drop_table :teste_de_conceito
  end
end
