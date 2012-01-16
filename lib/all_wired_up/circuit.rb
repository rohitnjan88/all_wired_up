module AllWiredUp
  class Circuit 
    
    def initialize(matrix)
      @matrix = matrix
      @switch_elements = ['0','1']
      @gate_elements =['A','X','O','N']
    end
  
    def find_back_element(position)
      x,y = position
      until @matrix[x][y-1] != "-" do  
        y -= 1
      end
      [x,y-1]
    end
    
    def left_input(position)
      x,y = position
      while @matrix[x-1][y] == '|'  and x-1 >= 0 do
         x -=1 
      end
      position = [x,y]
      find_back_element(position)
    end
    
    def right_input(position)
      x,y = position
      until x+1 < @matrix.count  and @matrix[x+1][y] != '|' do
         x +=1 
      end
      position = [x,y]
      find_back_element(position)
    end
  
    def solve_sub_circuit(position)
       x,y = position
       element  = @matrix[x][y]
       if @switch_elements.include?  element
         return element.to_i 
       elsif @gate_elements.include? element
         case element
            when 'A'
              result= (solve_sub_circuit left_input(position)) & (solve_sub_circuit right_input(position))
            when "X"
              result= (solve_sub_circuit left_input(position)) ^ (solve_sub_circuit right_input(position))
            when "O"
              result= (solve_sub_circuit left_input(position)) | (solve_sub_circuit right_input(position))
            when "N" 
              result=  ~ (solve_sub_circuit left_input(position))
          end
          return (result & 1)    # last bit 
       end
    end
    
    def solve_circuit(bulb_position)
      back_element = find_back_element(bulb_position)
      element =  solve_sub_circuit(back_element)
      return "on" if element == 1
      return "off" if element == 0
      "error in Circuit"
    end
  end
end
