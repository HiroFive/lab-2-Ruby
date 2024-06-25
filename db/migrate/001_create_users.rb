class CreateUsers < ActiveRecord::Migration[4.2]
    def change
      create_table :users, force: true do |t|
        t.integer :uid # id користувача в системі телеграм (message.from.id)
        t.string :username # імя користувача в системі телеграм (message.from.first_name)
        t.timestamps
      end
    end
  end
  