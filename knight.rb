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

  def inspect
    "#{color.to_s[0]}N "
  end

end
