require_relative 'piece.rb'

class SlidingPiece < Piece

  ROOK_DELTAS = [
    [ 1, 0],
    [ 0, 1],
    [ 0,-1],
    [-1, 0]
  ]

  BISHOP_DELTAS = [
    [ 1, 1],
    [ 1,-1],
    [-1, 1],
    [-1,-1]
  ]

  def moves
    valid_moves = []
    move_dirs.each do |dir|
      distance = 1
      while distance < Board::BOARD_SIZE
        test_coord = [
          distance * dir.first + @pos.first,
          distance * dir.last + @pos.last
        ]

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
