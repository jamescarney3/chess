class Rook < SlidingPiece

  attr_reader :castleable

  def initialize(board, color, pos, duped = false, castleable = true)
    super(board, color, pos, duped)
    @castleable = castleable
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
