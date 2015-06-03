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

  def inspect
    "#{color.to_s[0]}K "
  end

end
