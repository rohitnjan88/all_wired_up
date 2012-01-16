module AllWiredUp
  class  Parser
   
    attr_accessor :matrix,:bulb_positions
     
    def initialize(filename)
      @matrix,@bulb_positions = file_to_tokens(filename)
    end
  
    def file_to_tokens(filename)
      matrix,bulb_positions = [],[]
      x = 0
      File.open(filename,'r').each{ |line| 
        tokens  = line.split('')
        matrix << tokens
        bulb_positions << [x,tokens.index('@')] if tokens.include? '@'
        x +=  1
      }
      matrix.push []
      [matrix,bulb_positions]
    end
  end
end
