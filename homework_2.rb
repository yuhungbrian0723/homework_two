require 'pry'




class Player
  attr_accessor :hand,:name
  def initialize(name)
    @name = name
    @hand = nil
  end

  def pick_hand
    begin 
      puts "choose R P S"
      hand_input = gets.chomp.upcase
    end while !["R", "P", "S"].include?(hand_input) 
    self.hand = hand_input
  end
end



class HumanPlayer < Player
end




class ComputerPlayer < Player
  def pick_hand
    self.hand = ["R","P","S"].sample
  end
end





class Game
  HANDS = {R: "Rock", P: "Paper", S: "Scissors"}
  attr_accessor :human_player, :computer_player, :msg
  def initialize
    @human_player = HumanPlayer.new(get_user_name)
    @computer_player = ComputerPlayer.new("Matrix")
  end



  def get_user_name
    puts "what's your name:"
    gets.chomp.capitalize!
  end



  def intro
    puts "   #{self.human_player.name}! hi!"
  end

  def continue?
    begin
      puts "Again? Y / N"
      continue = gets.chomp.upcase
    end while !["Y", "N"].include?(continue)
    continue
  end


  def goodbye
    puts "bye"
    
  end
  def print_result(user_input, computer_input, message)
    puts "#{self.human_player.name} choose #{HANDS[user_input.to_sym]}, computer chooses #{HANDS[computer_input.to_sym]}, #{self.human_player.name} #{message}!"
    
  end

  def check_win(user_input, computer_input)
    if (user_input == computer_input)
      "draw"
    elsif user_input == "R"
      if computer_input == "S"
        "wins"
      elsif computer_input == "P"
        "loses"
      end
    elsif user_input == "P"
      if computer_input == "R"
        "wins"
      elsif computer_input == "S"
        return "loses"
      end
    elsif user_input == "S"
      if computer_input == "P"
        "wins"
      elsif computer_input == "R"
        "loses"
      end
    end
  end


  def play
    intro  
    begin 
      self.human_player.pick_hand
      self.computer_player.pick_hand
      self.msg = self.check_win(human_player.hand, computer_player.hand)
      print_result(self.human_player.hand, self.computer_player.hand, msg)
    end while continue? == "Y"
    goodbye
  end

end

Game.new.play