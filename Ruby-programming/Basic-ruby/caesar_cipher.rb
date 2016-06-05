def caesar_cipher(str, offset)
   str = str.chars.map do |c|

    case c.to_sym
    when (:a..:z)
      sum = 'a'.ord
    when (:A..:Z)
      sum = 'A'.ord
    else
      next c
    end

    ((c.ord - sum + offset) % ('z'.ord - 'a'.ord + 1) + sum).chr
  end
  puts str.join
  str.join
end

caesar_cipher("What a string!", 5)
puts "Bmfy f xywnsl!"
