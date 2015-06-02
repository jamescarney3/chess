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

  
end

class SlidingPiece < Piece

end

class Pawn < Piece

end

class Knight < SteppingPiece

end

class King < SteppingPiece

end

class Bishop < SlidingPiece

end

class Rook < SlidingPiece

end

class Queen < SlidingPiece

end


class NotImplementedError < StandardError
end
