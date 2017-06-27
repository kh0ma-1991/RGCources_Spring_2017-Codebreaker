require 'yaml'

module Codebreaker
  class ConsoleHelper
    def initialize
      @messages = messages
    end

    def messages
      begin
        file = File.new('./messages/messages.yml', 'r')
        messages = YAML.load(file.read)
      rescue IOError => e
        puts "Exception: #{e}"
        e
      ensure
        file.close unless file.nil?
      end
      messages
    end

    def read_str(in_game = false)
      result = STDIN.gets.chomp
      raise ExitException.new if result == 'exit'
      raise HintException.new if in_game && (result == 'hint')
      result
    end

    def print_exit_message
      puts(@messages[:EXIT_MESSAGE])
    end

    def print_greeting
      puts(@messages[:GREETING])
    end

    def print_attempts_wrong
      puts(@messages[:ATTEMPTS_WRONG])
    end

    def print_guess_wrong
      puts(@messages[:GUESS_WRONG])
    end

    def print_game_start(attempts)
      puts(@messages[:START_GAME] % attempts.to_s)
    end

    def print_marked_response(attempts, checked_code)
      puts(checked_code)
      print_left_attempts(attempts)
    end

    def print_left_attempts(attempts)
      puts(@messages[:LEFT_ATTEMPTS] % attempts.to_s)
    end

    def print_select_attempts
      puts(@messages[:SELECT_ATTEMPTS])
    end

    def print_win(secret_code)
      puts(@messages[:WIN] % secret_code)
    end

    def print_lose(secret_code)
      puts(@messages[:GAME_OVER] % secret_code)
    end

    def print_play_again?
      puts(@messages[:PLAY_AGAIN])
      loop do
        answer = read_str
        return true if yes? answer
        return false if no? answer
        puts(@messages[:PLAY_AGAIN_WRONG])
      end
    end

    private

    def yes?(answer)
      answer == 'yes'
    end

    def no?(answer)
      answer == 'no'
    end
  end
end
