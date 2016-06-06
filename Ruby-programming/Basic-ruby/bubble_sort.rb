def bubble_sort_by arr
  sorted = false
  until !!sorted
    sorted = true
    (arr.length - 1).times do |index|
      if (yield(arr[index], arr[index + 1]) > 0) then
        arr[index], arr[index + 1] = arr[index + 1], arr[index]
        sorted = false
      end
    end
  end
  arr
end

def bubble_sort arr
  bubble_sort_by(arr) { |l, r| l - r }
end

puts bubble_sort([4,3,78,2,0,2]).inspect
# => [0,2,2,3,4,78]

# WARNING: Here without the parenthesis the block would be passed to the puts function instead to the sort one
puts (bubble_sort_by(["hi","hello","hey"]) do |left, right|
  left.length - right.length
end)
# => ["hi", "hey", "hello"]
