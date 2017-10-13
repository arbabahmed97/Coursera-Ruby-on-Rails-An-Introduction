#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  #Implement the following read-only attributes in the LineAnalyzer class. 
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number      
  #- a number with maximum number of occurrences for a single word (calculated)
  #- an array of words with the maximum number of occurrences (calculated)
  #- the string analyzed (provided)
  #- the line number analyzed (provided)

  #Add the following methods in the LineAnalyzer class.
  #- taking a line of text (content) and a line number
  #Implement the initialize() method to:
  #* take in a line of text and line number
  #* initialize the content and line_number attributes
  #* call the calculate_word_frequency() method.  
  def initialize(content, line_number) 
    @content = content
    @line_number = line_number
    @highest_wf_words = []
    calculate_word_frequency() 
  end

  #- calculates result
  #Implement the calculate_word_frequency() method to:
  #* calculate the maximum number of times a single word appears within
  #  provided content and store that in the highest_wf_count attribute.
  #* identify the words that were used the maximum number of times and
  #  store that in the highest_wf_words attribute.
  def calculate_word_frequency() 
  	word_freq_hash = Hash.new(0)
  	sentence = @content

  	sentence.split.each do |word|
  		word_freq_hash[word.downcase] += 1
  	end

    @highest_wf_count = word_freq_hash.values.max
    word_freq_hash.each do |key,value|
      if @highest_wf_count == value
        @highest_wf_words.push(key)
      end 
    end    
  end	#calculate_word_frequency() end
  
end		#class LineAnalyzer end

#  Implement a class called Solution. 
class Solution   
  # *********************STEP********************
  # Implement the following methods in the Solution class.
  #* analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  #* calculate_line_with_highest_frequency() - determines the highest_count_across_lines and 
  #  highest_count_words_across_lines attribute values
  #* print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in 
  #  highest_count_words_across_lines in the specified format

  # Implement the following methods in the Solution class.
  # Implement the following read-only attributes in the Solution class.
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines
  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
  #  equal to the highest_count_across_lines determined previously.
  
  def initialize() 
    @analyzers = []  
  end

  #* analyze_file() - processes 'test.txt' into an array of LineAnalyzers and stores them in analyzers.
  # Implement the analyze_file() method() to:
  #* Read the 'test.txt' file in lines 
  #* Create an array of LineAnalyzers for each line in the file
  def analyze_file()
  	File.foreach('test.txt') do |line|
  		line_count = 0
		analyzer_instance = LineAnalyzer.new(line.chomp, line_count += 1)
  		@analyzers.push(analyzer_instance)
  	end    
  end

  # Implement the calculate_line_with_highest_frequency() method to:
  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  def calculate_line_with_highest_frequency()
    max_analyzer = @analyzers.max_by { |analyzer| analyzer.highest_wf_count }
    @highest_count_across_lines = max_analyzer.highest_wf_count
    @highest_count_words_across_lines = []
    @analyzers.each do |analyzer|
      if analyzer.highest_wf_count == @highest_count_across_lines
        @highest_count_words_across_lines.push(analyzer)
      end
    end
  end

  #Implement the print_highest_word_frequency_across_lines() method to
  #* print the values of objects in highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines
	puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |analyzer|
      puts analyzer.highest_wf_words, "(appears in line ", analyzer.line_number, ")"
    end
  end	

end  #class Solution end
