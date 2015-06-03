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
    King => "♔",
    Queen => "♕",
    Rook => "♖",
    Bishop => "♗",
    Knight => "♘",
    Pawn => "♙"
  }

  BLACK_PIECES = {
    King => "♚",
    Queen => "♛",
    Rook => "♜",
    Bishop => "♝",
    Knight => "♞",
    Pawn => "♟"
  }

  def initialize
    @board = Board.create_new_board
  end

  def play
    white = HumanPlayer.new(:white, @board)
    black = HumanPlayer.new(:black, @board)
    draw_board

    loop do
      puts "White's turn"
      white.play_turn
      draw_board

      break if @board.check_mate?(:black)

      puts "Black's turn"
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
    puts " #{TOP_FRAME.join} "
    Board::BOARD_SIZE.times do |rank|
      print_line(rank)
    end
    puts " #{TOP_FRAME.join} "
  end

  def print_line(rank)
    print SIDE_FRAME[rank]

    Board::BOARD_SIZE.times do |file|
      tile = @board[rank, file]
      if tile.nil?
        print " "
      elsif tile.color == :white
        print WHITE_PIECES[tile.class]
      else
        print BLACK_PIECES[tile.class]
      end
    end

    puts SIDE_FRAME[rank]
  end


end
