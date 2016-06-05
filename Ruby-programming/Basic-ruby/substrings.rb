def substrings str, dictionary
  str.downcase!
  hystogram = Hash.new(0)
  dictionary.each do |substr|
    hystogram[substr] = str.scan(substr.downcase).length if str.include? substr.downcase
  end
  hystogram = Hash[hystogram.sort_by { |k,v| v }.reverse]
  puts hystogram.inspect
  hystogram
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
# => {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}
