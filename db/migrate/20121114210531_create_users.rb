class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :firstname, :lastname, :picture_url, :headline

      t.timestamps
    end
  end
end
