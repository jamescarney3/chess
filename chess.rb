class Game

  def self.notation_lookup
    hash = Hash.new
    ("A".."H").each_with_index do |letter, file|
      (1..8).to_a.reverse.each_with_index do |num, rank|
         hash[letter + num.to_s] = [rank,file]
      end
    end

    hash
  end

  CHESS_NOTATION = self.notation_lookup

  def initialize
    @board = Board.create_new_board
  end

  def play
    white = HumanPlayer.new(:white, @board)
    black = HumanPlayer.new(:black, @board)

    loop do
      white.play_turn
      puts @board.inspect
      break if @board.check_mate?(:black)
      black.play_turn
      puts @board.inspect
      break if @board.check_mate?(:white)
    end

    puts "Someone won! We don't know who."

  end


end
