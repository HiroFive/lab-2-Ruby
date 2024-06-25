# завантаження всіх бібліотек
require_relative "../lib/load_libraries"

# налаштування параметрів для модуля тестів Quiz 
Quiz.config do |quiz|
  quiz.yaml_dir = "quiz/yml"
  quiz.answers_dir = "quiz/answers"
  quiz.log_dir = "log"
end

# налаштування параметрів для модуля QuizBot для роботи чат-бота 
QuizBot.config do |quiz_bot|
  quiz_bot.yaml_dir = "quiz/yml"
  quiz_bot.log_dir = "log"
end

engine = QuizBot::EngineBot.new
engine.run
