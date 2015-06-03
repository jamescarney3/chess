require 'byebug'

class Piece

attr_reader :color, :pos

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @board[*pos] = self
  end

  def moves
    raise NotImplementedError
  end

  def move_to(pos)
    @board[*@pos] = nil
    @pos = pos
    @board[*pos] = self
  end

  def dup(dup_board)
    self.class.new(dup_board, @color, @pos.dup)
  end

  def move_into_check?(end_pos)
    dup_board = @board.dup
    dup_board.move(@pos, end_pos)
    dup_board.in_check?(@color)
  end

  def valid_moves
    moves.select { |move| !move_into_check?(move) }
  end

  private

  def in_bounds?(pos)
    pos.all? { |coord| (0...Board::BOARD_SIZE).include?(coord) }
  end

  def occupied?(pos)
    !@board[*pos].nil?
  end

  def occupied_by_ally?(pos)
    if occupied?(pos)
      return @board[*pos].color == self.color
    end

    false
  end

  def occupied_by_enemy?(pos)
    if occupied?(pos)
      return @board[*pos].color != self.color
    end

    false
  end

end
