class SteppingPiece < Piece

  def deltas
    raise NotImplementedError
  end

  def moves
    deltas.map do |delta_rank, delta_file|
      [@pos.first + delta_rank, @pos.last + delta_file]
    end.select do |coord|
      in_bounds?(coord) && !occupied_by_ally?(coord)
    end
  end


end
