class CreateUserTopCaches < ActiveRecord::Migration[8.0]
  def change
    create_table :user_top_caches do |t|
      t.references :user, null: false, foreign_key: true
      t.string :cache_type
      t.string :time_range
      t.jsonb :data
      t.datetime :last_updated

      t.timestamps
    end
  end
end
