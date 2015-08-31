class King < SteppingPiece

  KING_SIDE_CASTLE_DELTA = [0, 2]
  KING_SIDE_CASTLE_INTERVENING_DELTAS = [
    [0,1],
    [0,2]
  ]

  QUEEN_SIDE_CASTLE_DELTA = [0, -2]
  QUEEN_SIDE_CASTLE_INTERVENING_DELTAS = [
    [0, -1],
    [0, -2],
    [0, -3]
  ]

  attr_reader :castleable

  def initialize(board, color, pos)
    super(board, color, pos)
    @castleable = true
  end

  def move_to(new_pos)
    super(new_pos)
    @castleable = false
  end

  def deltas
    SteppingPiece::KING_DELTAS
  end

  def inspect
    "#{color.to_s[0]}K "
  end

end
