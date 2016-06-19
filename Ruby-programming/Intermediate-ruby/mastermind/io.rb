module In_Out
  def get_user_input(str = nil)
    puts str
    gets.chomp
  end

  def get_turn_input(colors)
    puts "Type your secret code as a comma separated list of 4 colours"
    str = ''
    loop do
      str = gets.chomp.split(',').map(&:strip).delete_if(&:empty?).map(&:to_sym)
      case
      when str.length != 4
        puts "Wrong input, expected 4 comma separated values, like 'r,g,b,y'"
      when str.select { |s| colors.include?(s) }.length != 4
        puts "wrong input, valid color input are " << colors.join(', ')
      else
        break
      end
    end
    str
  end
end