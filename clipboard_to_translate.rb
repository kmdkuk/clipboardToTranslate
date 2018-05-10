require 'easy_translate'
require 'dotenv'

module ClipboardToTranslate
  class CLI
    attr_reader :argv

    def initialize(argv = [])
      @argv = argv.dup
    end

    def run
      # get text from clipboard
      text = `pbpaste`
      puts text
      # remove ¥n
      text.gsub!(/(\r\n|\r|\n)/, " ")
      puts text
      # throw google translate
      Dotenv.load
      text = EasyTranslate.translate(text, to: :japanese, key: ENV["GOOGLE_API_KEY"])
      puts text
      # result to clipboard
      # system "pbcopy", "\"#{text}\""
      IO.popen('pbcopy', 'w') { |f| f << text }
    end
  end
end
