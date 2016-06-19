# Getting input from user and split in only words:
# "red green, blue,magenta".split(/\W+/)
# Output: ["red", "green", "blue", "magenta"]

require './io'
require './board'

class Game
  include In_Out
  def initialize
    system('clear')
    @board = Board.new

    @secret_code =[]
    4.times do
      @secret_code << @board.colors[(rand * @board.colors.length).floor]
    end
    puts @secret_code.inspect
  end

  def play
    puts "Press enter when ready"
    gets
    loop do
      system('clear')
      puts @board
      if @board.game_over?
        puts '', @board.winner, "END OF THE GAME"
        break
      else
        turn_play = get_turn_input(@board.colors)

        @board.store_turn_input(turn_play)
        @board.rate_turn(@secret_code, turn_play)
        @board.current_turn += 1
      end
    end
  end
end

game = Game.new

game.play
