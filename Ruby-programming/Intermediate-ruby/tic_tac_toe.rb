class Game
  def initialize
    system('clear')

    @players = []
    2.times do |n|
      puts "Player #{n + 1} name:"
      name = gets.chomp
      chip = n == 0 ? :X : :O
      @players << Player.new(n, name, chip)
      puts "Player #{n + 1} chip is #{chip}"
    end

    @curr_player = rand.round

    @board = Board.new(3)
  end

  def play
    puts "Press enter when ready"
    gets
    loop do
      system('clear')
      puts @board.state
      if @board.game_over?
        puts @board.winner.nil? ? "Draw" : "#{@players[@board.winner].name} WINS", "END OF THE GAME"
        break
      else
        player = @players[@curr_player]
        @board.place_chip(player)
        @curr_player = (@curr_player + 1) % 2
      end
    end

  end
end

class Board
  attr_reader :size
  attr_accessor :winner
  def initialize(size = 3)
    @moves = 0
    @size = size
    @str_size = size * 3 + 2
    @header_str = ("_" * @str_size).center(@str_size + 10) << "\n"
    @footer_str = ("‾" * @str_size).center(@str_size + 10) << "\n"
    @board = Array.new(size) { Array.new(size, ' ') }
  end

  def state
    state_str = @board.reduce(@header_str.dup) do |str, row|
      row_str = '| ' << row.map(&:to_s).join(' | ') << ' |'
      str << row_str.center(@str_size + 10) << "\n"
    end
    state_str << @footer_str
  end

  def place_chip player
    puts "#{player.name}'s turn"
    x, y = 0, 0
    loop do
      puts "Input x position:"
      x = gets[0].to_i - 1
      puts "Input y position:"
      y = gets[0].to_i - 1

      next puts "Invalid move (#{x + 1}, #{y + 1}), valid input >= 1 and <= #{@size}" unless (0...@size) === x && (0...@size) === y
      next puts "Invalid move (#{x + 1}, #{y + 1}), slot not empty" unless @board[y][x] == ' '
      break
    end
    @board[y][x] = player.chip
    @moves += 1
    check_win_move(x, y, player)
  end

  def game_over?
    @moves > 8 || winner
  end

  private
    def check_win_move x, y, player
      if check_column_win(x, player.chip) ||
        check_row_win(y, player.chip) ||
        check_diag_win(player.chip)
        @winner = player.id
      end
    end

    def check_column_win(x, chip)
      @board.each { |row| return false unless row[x] == chip }
      true
    end

    def check_row_win(y, chip)
      @board[y].each { |slot| return false unless slot == chip }
      true
    end

    def check_diag_win(chip)
      win_value = (0...@size).reduce([true, true]) do |condition, i|
        unless @board[i][i] == chip
          condition[0] = false
        end
        unless @board[i][@size - i - 1] == chip
          condition[1] = false
        end
        condition
      end

      win_value[0] || win_value[1]
    end
end

class Player
  attr_reader :id, :name, :chip
  def initialize(id, name, chip = 'X')
    @id = id
    @name = name
    @chip = chip
  end
end

game = Game.new
game.play
