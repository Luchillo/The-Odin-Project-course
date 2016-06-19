class Board
  attr_reader :colors, :winner
  attr_accessor :current_turn

  def initialize()
    # Max plays possible in a game
    @max_plays = 4
    @current_turn = 0
    @colors = [:r, :g, :b, :y, :o, :m]
    @winner = 'AI wins'

    description = "Colors: red, green, blue, yellow, orange, magenta\n"
    description << "Expected input with initial chars of color like: r,b,y,m\n\n"
    description << "The result rating uses 't' for right placed, 'w' for wrong placed\n"
    description << "chars and empty for none of them, the output doesn't refer to the\nactual places of the chars\n\n"

    board_header  = "╔═══╦═══╦═══╦═══╗ ╔═══╦═══╦═══╦═══╗"
    @wall    = "║"
    @floor   = "╠═══╬═══╬═══╬═══╣ ╠═══╬═══╬═══╬═══╣"
    @footer  = "╚═══╩═══╩═══╩═══╝ ╚═══╩═══╩═══╩═══╝"
    @padding = ' ' * 4

    @plays         = Array.new(@max_plays) { Array.new(4, ' ') }
    @results       = Marshal.load(Marshal.dump(@plays))

    plays_title   = 'Play'.center(board_header.length / 2)
    results_title = 'Result'.center(board_header.length / 2)
    title = @padding + plays_title + ' ' + results_title

    @header = [description, title, @padding + board_header].join("\n")
  end

  def store_turn_input(turn_play)
    turn_play.each_with_index do |c, i|
      @plays[@current_turn][i] = c
    end
  end

  def rate_turn(secret_code, turn_play)
    unmatched_chars = []
    result = []
    turn_play.each_with_index do |c, i|
      if secret_code[i] === c
        result << :t
      elsif turn_play.find_index(c) === i
        unmatched_chars << c
      end
    end

    unmatched_chars.each_with_index do |c, i|
      result << :w if secret_code.include? c
    end

    result.each_with_index { |c, i| @results[@current_turn][i] = c }
  end

  def game_over?
    return false if @current_turn === 0

    win = @results[@current_turn - 1].all? { |res| res === :t }
    @winner = 'Player wins' if win

    @current_turn >= @max_plays || win
  end

  def to_s
    content = (0...@max_plays).reduce('') do |row, i|
      play_result = @wall.dup
      play_result << (0...4).reduce('') do |str, j|
        str << ' ' << @plays[i][j].to_s << ' ' << @wall
      end

      play_result << ' ' << @wall.dup() << (0...4).reduce('') do |str, j|
        str << ' ' << @results[i][j].to_s << ' ' << @wall
      end

      row << @padding << play_result << "\n"
      row << @padding << @floor << "\n" if i < @max_plays - 1
      row
    end

    [@header, content].join("\n") << @padding + @footer << "\n\n"
  end
end