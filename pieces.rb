class Piece

  def initialize(board, color, pos)
    @board = board
    @color = color #:white or :black
    @pos = pos #[rank, file]
  end

  def moves
    raise NotImplementedError
  end

  private

  def in_bounds?(pos)
    pos.all? {|coord| (0...Board::BOARD_SIZE).include?(coord)}
  end

end

class SteppingPiece < Piece

  def deltas
    raise NotImplementedError
  end

  def moves
    deltas.map do |delta_rank, delta_file|
      [@pos.first + delta_rank, @pos.last +delta_file]
    end.select do |coord|
      in_bounds?(coord) && !occupied?(coord)
    end
  end


end

class SlidingPiece < Piece

end

class Pawn < Piece

end

class Knight < SteppingPiece

  def deltas
    [
      [ 2,  1],
      [ 2, -1],
      [ 1,  2],
      [ 1, -2],
      [-1,  2],
      [-1, -2],
      [-2,  1],
      [-2, -1]
    ]
  end



end

class King < SteppingPiece

  def deltas
    [
      [ 1,  1],
      [ 1,  0],
      [ 1, -1],
      [ 0,  1],
      [ 0, -1],
      [-1,  1],
      [-1,  0],
      [-1, -1]
    ]
  end

  def moves

  end

end

class Bishop < SlidingPiece

end

class Rook < SlidingPiece

end

class Queen < SlidingPiece

end


class NotImplementedError < StandardError
end
