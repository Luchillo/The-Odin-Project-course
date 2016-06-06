def stock_picker(stock_arr)
  better_investment = {
    buy_day: 0,
    sell_day: 1,
    profit: stock_arr[1] - stock_arr.first
  }
  stock_arr.each_with_index do |buy_value, buy_day|
    (buy_day + 1..stock_arr.length-1).each do |sell_day|
      profit = stock_arr[sell_day] - buy_value
      if profit > better_investment[:profit]
        better_investment[:buy_day], better_investment[:sell_day], better_investment[:profit] = buy_day, sell_day, stock_arr[sell_day] - buy_value
      end
    end
  end
  better_investment.values_at(:buy_day, :sell_day)
end

puts stock_picker([17,3,6,9,15,8,6,1,10]).inspect
# Should output [1,4] for a profit of $15 - $3 == $12
