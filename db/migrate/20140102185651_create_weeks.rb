class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.datetime :publishing_date
      t.timestamps
    end

    add_column :notes, :week_id, :integer
  end
end
