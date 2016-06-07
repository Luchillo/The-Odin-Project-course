module Enumerable
  def my_each
    return to_enum unless block_given?
    (length).times do |i|
      yield self[i]
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?
    (length).times do |i|
      yield self[i], i
    end
    self
  end

  def my_select
    return to_enum unless block_given?
    selected = []
    my_each do |v|
      selected << v if yield(v)
    end
    selected
  end

  def my_all?
    return to_enum unless block_given?
    my_each do |v|
      return false unless yield(v)
    end
    true
  end

  def my_any?
    return to_enum unless block_given?
    my_each do |v|
      return true if yield(v)
    end
    false
  end

  def my_none?
    return to_enum unless block_given?
    my_each do |v|
      return false if yield(v)
    end
    true
  end

  def my_count(n = nil)
    return length if n.nil? && !block_given?
    count = 0
    unless n.nil?
      my_each { |v| count += 1 if n == v }
    else
      my_each { |v| count += 1 if yield(v) }
    end
    count
  end

  def my_map(proc = nil)
    return to_enum unless block_given? || !proc.nil?
    arr = []
    my_each do |v|
      next arr << proc.call(v) unless proc.nil?
      arr << yield(v)
    end
    arr
  end

  def my_inject(*params)
    accumulator = 0
    case
    when params.length == 2 || params.length == 1 && block_given?
      accumulator = params[0]
      self.my_each do |v|
        next accumulator = accumulator.send(params[1], v) if params.length == 2
        accumulator = yield(accumulator, v)
      end
    else block_given?
      accumulator = self[0]
      self[1..-1].my_each do |v|
        next accumulator = yield(accumulator, v) if block_given?
        accumulator = accumulator.send(params[0], v)
      end
    end
    accumulator
  end

end

def multiply_els(arr)
  arr.my_inject(:*)
end

puts [1,2,3].my_each { |n| puts n*2 }.inspect
# => [2,4,6]
puts [1,2,3].my_each_with_index { |n, i| puts "index: #{i}, value: #{n*2}" }.inspect
# => index: 0, value: 2
# => index: 1, value: 4
# => index: 2, value: 6
puts [1,2,3].my_select { |n| n > 1 }.inspect
#  => [2,3]
puts [1,2,3].my_all? { |n| n >= 1 }
# => true
puts [1,2,3].my_any? { |n| n > 2 }
# => true
puts [4,2,3].my_count
puts [4,2,3].my_count(1)
puts [4,2,3].my_count { |v| v >= 3 }
# => 3
# => 0
# => 2
puts [4,2,3].my_map { |v| v * 3 }.inspect
puts [4,2,3].my_map(Proc.new { |v| v * 2 }).inspect
puts [4,2,3].my_map(Proc.new { |v| v * 3 }) { |v| v * 2 }.inspect
# => [12,6,9]
# => [8,4,3]
# => [12,6,9]
puts [1,2,3].my_inject(1, :*) { |sum,v| sum += v }.inspect
puts [1,2,3].my_inject(2) { |sum,v| sum += v }.inspect
# puts [1,2,3].my_inject(:+) { |sum,v| sum += v }.inspect  ### This outputs an error of undefined methor + for :+ symbol
puts [1,2,3].my_inject(3, :*).inspect
puts [1,2,3].my_inject(:+).inspect
puts [1.0,2,3].my_inject { |sum,v| sum /= v }.inspect
# => 6
# => 8
# => 18
# => 0.1666666
puts multiply_els([2,4,5])
# => 40
puts
