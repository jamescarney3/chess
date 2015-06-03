class HumanPlayer


  def initialize(color, board)
    @color = color
    @board = board
  end

  def play_turn

  end

  private

  def get_move
    puts "Input a move (e.g. E2-E4)"
    input = gets.chomp.upcase
    if invalid_input?(input)
      raise InvalidSelectionError.new("Bad input format.")
    end

    start_pos = Game::CHESS_NOTATION[input[0..1]]
    end_pos = Game::CHESS_NOTATION[input[3..4]]
    target = @board[*start_pos]

    raise InvalidSelectionError if target.color != @color || target.nil?




  end

  def pick_piece

  end

  def place_piece

  end

  def invalid_input?(input)
    !/\A[A-H][1-8]-[A-H][1-8]\z/.match(input)
  end


end

class InvalidSelectionError < StandardError
end
