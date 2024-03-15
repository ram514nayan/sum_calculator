class Calculator
  def add_numbers str
    @errors = ''
    @input_string, delimiter = check_delimiter str
    @regex_str = /^[\d\(\)\-#{delimiter}]+$/

    print "Input: #{str}: || "
    numbers = @input_string.split(delimiter).map(&:to_i)
    validate_string
    validate_last_line
    negative_numbers numbers

    if @errors.empty?     
      puts "Output: #{numbers.sum}"
    else
      puts "Errors: #{@errors}"
    end
  end

  def negative_numbers numbers
    negative_nums = numbers.select(&:negative?)
    begin
      raise "Negative numbers" if negative_nums.any?
    rescue StandardError => e
      @errors.concat("#{e} are not allowed: #{negative_nums.join(', ')}, ")
    end
  end

  def check_delimiter str
    if(str[0..1].include?("//"))
      delimiter = str[2]
      validate_delimiter delimiter
      str = str[3..str.length-1]
    else
      delimiter = ','
    end
    return str, delimiter
  end

  def validate_delimiter del
    begin
      raise 'Invalid input: Delimiter should not be number' unless del.to_s.match? /^(?![0-9]+$).*/
    rescue StandardError => e
      @errors.concat("#{e}, ")
    end
  end

  # Testing for only accepting numbers with delimiters
  def validate_string
    begin
      raise "Invalid input: Only allowed specified delimiter as (//delimiter) with integer" unless @input_string.match @regex_str
    rescue StandardError => e
      @errors.concat("#{e}, ")
    end
  end

  def validate_last_line
    begin
      raise "Invalid input: Last line should not be empty" if @input_string[-2..-1].include?("\n")
    rescue StandardError => e
      @errors.concat("#{e}, ")
    end
  end
end

calculator = Calculator.new

#Positive flow
calculator.add_numbers "1,2,3,4"

#Do not accept negative numbers
calculator.add_numbers "1,2,-3,-4"

#With ifferent delimiter, delimiter is @
calculator.add_numbers "//@10@15@7"

#With ifferent delimiter with negative numbers || delimiter is 'A'
calculator.add_numbers "//A10A15A7A14"

#With ifferent delimiter, should not be number
calculator.add_numbers "//910915979-14"

#Validation for last new line
calculator.add_numbers "//q1q-2q400q5\n"