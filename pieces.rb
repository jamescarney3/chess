require_relative 'board.rb'
require_relative 'chess.rb'
require 'byebug'

class Piece

attr_reader :color, :pos

  def initialize(board, color, pos)
    @board = board
    @color = color #:white or :black
    @pos = pos #[rank, file]
  end

  def moves
    raise NotImplementedError
  end

  def move_to(pos)
    @board[*@pos] = nil
    @pos = pos
    @board[*pos] = self
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
  TOP_PAWN_RANK = 1

  def initialize(board, color, pos)
    super
    @moved = false
    @direction = find_direction(pos)
  end

  def moves
    attackable_coords + marchable_coords
  end

  def inspect
    "#{color.to_s[0]}P "
  end
  private

  def attackable_coords
    attackable = []
    attack_deltas.each do |attack_coord|

      test_coord = [
        attack_coord.first + @pos.first,
        attack_coord.last + @pos.last
      ]

      if in_bounds?(test_coord) && occupied_by_enemy?(test_coord)
        attackable << test_coord
      end
    end

    attackable
  end

  def marchable_coords
    marchable = []
    steps = @moved ? 1 : 2
    steps.times do |step|
      test_coord = [
        @pos.first + (march_delta.first * (step + 1)),
        @pos.last
      ]
      break if occupied?(test_coord)
      marchable << test_coord
    end

    marchable
  end

  def march_delta
    @direction == :up ? [-1, 0] : [1, 0]
  end

  def attack_deltas
    if @direction == :up
      [[-1, -1], [-1, 1]]
    else
      [[1, -1], [1, 1]]
    end
  end

  def find_direction(pos)
    pos.first == TOP_PAWN_RANK ? :down : :up
  end

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

  def inspect
    "#{color.to_s[0]}N "
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

  def inspect
    "#{color.to_s[0]}K "
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

  def inspect
    "#{color.to_s[0]}B "
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

  def inspect
    "#{color.to_s[0]}R "
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

  def inspect
    "#{color.to_s[0]}Q "
  end

end
