class GeneratingSchemaFromScratch < ActiveRecord::Migration
  def self.up
    create_table :citations do |t|
      t.integer :id
      t.integer :version_id
      t.string :message
      t.integer :user_id
      t.timestamps
    end

    create_table :comments do |t|
      t.integer :id
      t.text    :message
      t.integer :user_id
      t.timestamps
    end
    
    create_table :note_comments do |t|
      t.integer :comment_id
      t.integer :note_id
      t.timestamps
    end

    create_table :notes do |t|
      t.integer :id
      t.string  :name
      t.integer :user_id
      t.timestamps
    end

    create_table :users do |t|
      t.integer :id
      t.string :login
      t.string :name
      t.string :lastname
      t.string :password
      t.text :description
      t.timestamps
    end
    
    create_table :versions do |t|
      t.integer :id
      t.text    :body
      t.integer :note_id
      t.integer :user_id
      t.boolean :deleted
      t.timestamps
    end
  end

  def self.down
    drop_table :citations
    drop_table :comments
    drop_table :note_comments
    drop_table :notes
    drop_table :users
    drop_table :versions

  end
end
