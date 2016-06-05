def caesar_cipher(str, offset)
   str = str.chars.map do |c|
    next c unless /[A-Za-z]/ =~ c

    case c
    when ('a'..'z')
      sum = 'a'.ord
    when ('A'..'Z')
      sum = 'A'.ord
    else
      sum = 0
    end

    ((c.ord - sum + offset) % ('z'.ord - 'a'.ord + 1) + sum).chr
  end
  puts str.join
  str.join
end

caesar_cipher("What a string!", 5)
puts "Bmfy f xywnsl!"
