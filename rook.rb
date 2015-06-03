class Rook < SlidingPiece

  def move_dirs
    [
      [ 1, 0],
      [ 0, 1],
      [ 0,-1],
      [-1, 0]
    ]
  end

  def inspect
    "#{color.to_s[0]}R "
  end

end
