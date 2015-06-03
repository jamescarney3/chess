class Bishop < SlidingPiece

  def move_dirs
    [
      [ 1, 1],
      [ 1,-1],
      [-1, 1],
      [-1,-1]
    ]
  end

  def inspect
    "#{color.to_s[0]}B "
  end

end
