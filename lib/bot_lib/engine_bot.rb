module QuizBot
    class EngineBot
      def initialize
        @token = YAML.load_file(File.expand_path("../../config/secrets.yml", __dir__))['telegram_bot_token']
        I18n.load_path << File.expand_path("../../config/locales.yml", __dir__)
        I18n.default_locale = :en
        @questions = Quiz::QuestionData.new
      end
  
      def run
        Telegram::Bot::Client.run(@token) do |bot|
          bot.listen do |message|
            case message.text
            when '/start'
              start_test(bot, message)
            when '/stop'
              stop_test(bot, message)
            when /^\/c \d+$/
              question_number = message.text.split.last.to_i
              send_question(bot, message, question_number)
            end
          end
        end
      end
  
      private
  
      def start_test(bot, message)
        user = find_or_create_user(message.from.id, message.from.username)
        bot.api.send_message(chat_id: message.chat.id, text: I18n.t(:greeting_message))
        # Add additional logic to start the test
      end
  
      def stop_test(bot, message)
        bot.api.send_message(chat_id: message.chat.id, text: I18n.t(:farewell_message))
      end
  
      def send_question(bot, message, question_number)
        question = @questions.collection[question_number - 1]
        answers_markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
          keyboard: question.question_answers.keys.map { |char| [char] },
          one_time_keyboard: true
        )
        bot.api.send_message(chat_id: message.chat.id, text: question.to_s, reply_markup: answers_markup)
      end
  
      def find_or_create_user(uid, username)
        User.find_or_create_by(uid: uid) do |user|
          user.username = username
        end
      end
    end
  end
  