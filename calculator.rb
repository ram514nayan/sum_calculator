class Calculator
  def add_numbers str
    print "Input: #{str}: || "
    numbers = str.split(',').map(&:to_i)
    negative_numbers numbers
  end

  def negative_numbers numbers
    negative_nums = numbers.select(&:negative?)
    begin
      raise "Negative numbers" if negative_nums.any?
      puts "Output: #{numbers.sum}"
    rescue StandardError => e
      puts "Negative numbers not allowed: #{negative_nums.join(', ')}"
    end
  end
end

calculator = Calculator.new

#Positive flow
calculator.add_numbers "1,2,3,4"

#Do not accept negative numbers
calculator.add_numbers "1,2,-3,-4"
