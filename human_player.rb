class HumanPlayer


  def initialize(color, board)
    @color = color
    @board = board
  end

  def play_turn
    input = get_move

    start_pos = Game::CHESS_NOTATION[input[0..1]]
    end_pos = Game::CHESS_NOTATION[input[3..4]]
    target = @board[*start_pos]

    if target.nil?
      raise InvalidSelectionError.new("No piece there.")
    elsif target.color != @color
      raise InvalidSelectionError.new("Not your piece.")
    elsif !target.valid_moves.include?(end_pos)
      raise InvalidSelectionError.new("Can't move there.")
    end

    @board.move(start_pos, end_pos)
  rescue InvalidSelectionError => error
    puts error.message
    retry

  end

  private

  def get_move
    puts "Input a move (e.g. E2-E4)"
    input = gets.chomp.upcase

    if invalid_input?(input)
      raise InvalidSelectionError.new("Bad input format.")
    end

    input
  end

  def invalid_input?(input)
    !/\A[A-H][1-8]-[A-H][1-8]\z/.match(input)
  end


end

class InvalidSelectionError < StandardError
end
