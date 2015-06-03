class Game

  CHESS_NOTATION = self.notation_lookup

  def self.notation_lookup
    hash = Hash.new
    ("A".."H").each_with_index do |letter, file|
      (1..8).reverse.each_with_index do |num, rank|
         hash[letter + num.to_s] = [rank,file]
      end
    end

    hash
  end

  def initialize
    @board = Board.create_new_board
  end

  def play

    while

    end

  end


end
