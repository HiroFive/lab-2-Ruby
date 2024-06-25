class CreateQuizTests < ActiveRecord::Migration[4.2]
    def change
      create_table :quiz_tests, force: true do |t|
        t.integer :current_question, default: 0 # поточне запитання тесту
        t.integer :status, default: 0 # 0 - not started; 1 - in_progress; 2 - finished
        t.integer :correct_answers, default: 0 # правильні відповіді
        t.integer :incorrect_answers, default: 0 # неправильні відповіді
        t.decimal :percent, precision: 10, scale: 2, default: 0 # відсоток правильних відповідей
        t.references :user, foreign_key: true # зовнішній ключ
        t.timestamps # створення полів created_at, updated_at
      end
    end
  end
  