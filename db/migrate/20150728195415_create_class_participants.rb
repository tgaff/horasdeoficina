class CreateClassParticipants < ActiveRecord::Migration
  def change
    create_table :class_participants do |t|
      t.references :role, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
