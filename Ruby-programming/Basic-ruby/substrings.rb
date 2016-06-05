def substrings str, dictionary
  str_arr = str.downcase.split
  hystogram = {}
  str_arr.each do |word|
    dictionary.each do |substr|
      if word.include? substr.downcase
        hystogram[substr] ||= 0
        hystogram[substr] += 1
      end
    end
  end
  puts hystogram
  hystogram
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
# => {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}
