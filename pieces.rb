require_relative 'board.rb'
require_relative 'chess.rb'

class Piece

attr_reader :color

  def initialize(board, color, pos)
    @board = board
    @color = color #:white or :black
    @pos = pos #[rank, file]
  end

  def moves
    raise NotImplementedError
  end

  private

  def in_bounds?(pos)
    pos.all? {|coord| (0...Board::BOARD_SIZE).include?(coord)}
  end

  def occupied?(pos)
    !@board[*pos].nil?
  end

  def occupied_by_ally?(pos)
    if occupied?(pos)
      return @board[*pos].color == self.color
    end

    false
  end

  def occupied_by_enemy?(pos)
    if occupied?(pos)
      return @board[*pos].color != self.color
    end

    false
  end

end

class SteppingPiece < Piece

  def deltas
    raise NotImplementedError
  end

  def moves
    deltas.map do |delta_rank, delta_file|
      [@pos.first + delta_rank, @pos.last + delta_file]
    end.select do |coord|
      in_bounds?(coord) && !occupied_by_ally?(pos)
    end
  end


end

class SlidingPiece < Piece

  def moves
    valid_moves = []
    move_dirs.each do |dir|
      distance = 1
      while distance < Board::BOARD_SIZE
        test_coord = [distance * dir.first + @pos.first,
                      distance * dir.last + @pos.last]

        if !in_bounds?(test_coord) || occupied_by_ally?(test_coord)
          break
        end

        valid_moves << test_coord
        break if occupied_by_enemy?(test_coord)

        distance += 1
      end
    end

    valid_moves
  end

  def move_dirs
    raise NotImplementedError
  end

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

  def move_dirs
    [
      [ 1, 1],
      [ 1,-1],
      [-1, 1],
      [-1,-1]
    ]
  end

end

class Rook < SlidingPiece

  def move_dirs
    [
      [ 1, 0],
      [ 0, 1],
      [ 0,-1],
      [-1, 0]
    ]
  end

end

class Queen < SlidingPiece

  def move_dirs
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
