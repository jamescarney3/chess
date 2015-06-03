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
  WHITE_PIECES = {
    King => "\u2654",
    Queen => "\u2655",
    Rook => "\u2656",
    Bishop => "\u2657",
    Knight => "\u2658",
    Pawn => "\u2659"
  }
  BLACK_PIECES = {
    King => "\u265A",
    Queen => "\u265B",
    Rook => "\u265C",
    Bishop => "\u265D",
    Knight => "\u265E",
    Pawn => "\u265F"
  }

  def initialize
    @board = Board.create_new_board
  end

  def play
    white = HumanPlayer.new(:white, @board)
    black = HumanPlayer.new(:black, @board)

    loop do
      white.play_turn
      draw_board
      break if @board.check_mate?(:black)
      black.play_turn
      draw_board
      break if @board.check_mate?(:white)
    end

    if @board.check_mate?(:black)
      puts "White wins!"
    elsif
      @board.check_mate?(:white)
      puts "Black wins!"
    else
      puts "Draw game?" #not actually checking for draws yet.
    end

  end

  private

  TOP_FRAME = ("a".."h").to_a
  SIDE_FRAME = ("1".."8").to_a.reverse

  def draw_board


  end

  def print_line(rank)
    print SIDE_FRAME[rank]

    Board::BOARD_SIZE.times do |file|
      tile = @board[rank, file]
      if tile.nil?
        print " "
      elsif tile.color == :white
        print WHITE_PIECES[tile.class].encode('utf-8')
      else
        print BLACK_PIECES[tile.class].encode('utf-8')
      end
    end

    puts SIDE_FRAME[rank]
  end


end
