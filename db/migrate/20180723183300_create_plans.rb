class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :stripe_plan_id
      t.string :interval
      t.boolean :available
      t.boolean :active

      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
