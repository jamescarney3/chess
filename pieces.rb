class Piece

  def initialize(board, color, pos)
    @board = board
    @color = color #:white or :black
    @pos = pos #[rank, file]
  end

  def moves
    raise NotImplementedError
  end

end

class SteppingPiece < Piece

  def deltas
    raise NotImplementedError
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
end

class Bishop < SlidingPiece

end

class Rook < SlidingPiece

end

class Queen < SlidingPiece

end


class NotImplementedError < StandardError
end
