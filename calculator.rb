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

# For checking different delimiter and its test case
  def check_delimiter str
    if(str[0..1].include?("//"))
      delimiter = str[2]
      delimiter_check delimiter
      str = str[3..str.length-1]
    else
      delimiter = ','
    end
    return str, delimiter
  end

  def delimiter_check del
    begin
      raise "Invalid input: Delimiter should not be number." unless del.to_s.match? /^(?![0-9]+$).*/
    rescue StandardError => e
      puts e
    end
  end

end

calculator = Calculator.new

#Positive flow
calculator.add_numbers "1,2,3,4"

#Do not accept negative numbers
calculator.add_numbers "1,2,-3,-4"
