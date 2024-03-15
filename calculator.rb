class Calculator
  def add_numbers(input_str)
    @errors = ''
    @input_string, delimiter = check_delimiter(input_str)
    @regex_str = /^[\d\(\)\-#{delimiter}]+$/

    input_type = input_str.include?("\n") ? 'Multi line' : 'Single line'
    print "#{input_type} Input: #{input_str}: || "

    validate_last_line input_str
    numbers = @input_string.split(delimiter).map(&:to_i)
    validate_string
    handle_negative_numbers(numbers)

    if @errors.empty?
      puts "Output: #{numbers.sum}"
    else
      puts "Errors: #{@errors}"
    end
  end

  def handle_negative_numbers(numbers)
    negative_nums = numbers.select(&:negative?)
    @errors.concat("Negative numbers are not allowed: #{negative_nums.join(', ')}, ") unless negative_nums.empty?
  end

  # Return used delimiter and modified string
  def check_delimiter(input_str)
    delimiter = ','
    if input_str[0..1].include?("//")
      delimiter = input_str[2]
      validate_delimiter(delimiter)
      input_str = input_str[3..-1]
    end
    input_str = input_str.gsub(/-\n+/, "#{delimiter}-").split("\n").join(delimiter)
    [input_str, delimiter]
  end

  #This will validate delimiter should not be number it also can cause error
  def validate_delimiter(del)
    @errors.concat("Invalid input: Delimiter should not be number, ") unless del.to_s.match? /^(?![0-9]+$).*/
  end

  # Validating for only accept numbers with delimiters
  def validate_string
    unless @input_string.match @regex_str
      @errors.concat("Invalid input: Only allowed specified delimiter as (//delimiter) with integer, ")
    end
  end

  # As mention (The following input is invalid: "1,\n") any last line should not be empty
  def validate_last_line(input_str)
    @errors.concat("Invalid input: Last line should not be empty, ") if input_str[input_str.length-1] == "\n"
  end
end


calculator = Calculator.new

#Positive flow
calculator.add_numbers "1,2,3,4"

#Do not accept negative numbers
calculator.add_numbers "1,2,-3,-4"

#With different delimiter, delimiter is @
calculator.add_numbers "//@10@15@7"

#With different delimiter with negative numbers || delimiter is 'A'
calculator.add_numbers "//A10A15A7A14"

#With different delimiter, should not be number
calculator.add_numbers "//910915979-14"

#Validation for last new line with multiple new lines and negative numbers
calculator.add_numbers "23,43,34-\n\n\n234\n-21,45,\n,-\n,50\n"
calculator.add_numbers "//;23;43;34\n\n\n234\n21;45;\n;\n50"
