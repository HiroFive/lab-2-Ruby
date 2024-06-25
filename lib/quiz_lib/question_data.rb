module Quiz
  class QuestionData
    attr_accessor :collection

    def initialize
      @collection = []
      load_data
    end

    def to_yaml
      @collection.to_yaml
    end

    def save_to_yaml(filename)
      File.write(filename, to_yaml)
    end

    def to_json
      @collection.to_json
    end

    def save_to_json(filename)
      File.write(filename, to_json)
    end

    def prepare_filename(filename)
      File.expand_path(filename, __dir__)
    end

    def each_file
      Dir.glob("#{Quiz.config.yaml_dir}/*.yml") { |file| yield file }
    end

    def load_data
      each_file do |filename|
        questions_data = YAML.safe_load(File.read(filename))
        questions_data.each do |question_data|
          question = Question.new(question_data['question'], question_data['answers'])
          @collection << question
        end
      end
    end

    def find_question(number)
      @collection[number - 1]
    end
  end
end
