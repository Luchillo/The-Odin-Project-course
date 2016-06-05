def substrings str, dictionary
  str_arr = str.downcase.split
  hystogram = Hash.new(0)
  str_arr.each do |word|
    dictionary.each do |substr|
      hystogram[substr] += 1 if word.include? substr.downcase
    end
  end
  puts hystogram
  hystogram
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
# => {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}