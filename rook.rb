class Rook < SlidingPiece

  attr_reader :castleable

  def initialize(board, color, pos)
    super(board, color, pos)
    @castleable = true
  end

  def move_to(pos)
    super(pos)
    @castleable = false
  end

  def move_dirs
    SlidingPiece::ROOK_DELTAS
  end

  def inspect
    "#{color.to_s[0]}R "
  end

end
