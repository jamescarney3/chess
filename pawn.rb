require 'byebug'
class Pawn < Piece
  TOP_PAWN_RANK = 1
  BOTTOM_PAWN_RANK = 6

  attr_accessor :direction, :en_passantable

  def initialize(board, color, pos)
    super
    @direction = find_direction(pos)
    @en_passantable = false
  end

  def move_to(new_pos)
    unless @board.occupied_by_enemy?(new_pos, @color) || pos[1] == new_pos[1]
      if @board.en_passant_attackable?(en_passant_coord(new_pos), @color)
        @board[en_passant_coord(new_pos)] = nil
      end
    end

    if (new_pos[0] - @pos[0]).abs == 2
      @en_passantable = true
    end

    super(new_pos)
  end

  def moves
    attackable_coords + marchable_coords
  end

  def inspect
    "#{color.to_s[0]}P "
  end

  def dup(dup_board)
    new_pawn = Pawn.new(dup_board, @color, @pos)
    new_pawn.direction = @direction

    new_pawn
  end

  private

  def attackable_coords
    attackable = []
    attack_deltas.each do |attack_coord|

      test_coord = [
        attack_coord.first + @pos.first,
        attack_coord.last + @pos.last
      ]

      if Board.in_bounds?(test_coord) &&
          (@board.occupied_by_enemy?(test_coord, @color) ||
          @board.en_passant_attackable?(en_passant_coord(test_coord), @color))
        attackable << test_coord
      end
    end

    attackable
  end

  def marchable_coords
    marchable = []

    steps = @pos[0] == TOP_PAWN_RANK ||
      @pos[0] == BOTTOM_PAWN_RANK ? 2 : 1

    steps.times do |step|
      test_coord = [
        @pos.first + (march_delta.first * (step + 1)),
        @pos.last
      ]
      break if @board.occupied?(test_coord) ||
        !Board.in_bounds?(test_coord)
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

  def en_passant_coord(attack_coord)
    [attack_coord.first + (@direction == :up ? 1 : -1),
    attack_coord.last]
  end

  def find_direction(pos)
    pos.first == TOP_PAWN_RANK ? :down : :up
  end

end
