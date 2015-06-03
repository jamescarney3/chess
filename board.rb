require 'byebug'
class Board

  BOARD_SIZE = 8
  BACK_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  FRONT_ROW = [Pawn] * BOARD_SIZE

  def self.create_new_board
    Board.new.set_pieces
  end

  def self.in_bounds?(pos)
    pos.all? { |coord| (0...BOARD_SIZE).include?(coord) }
  end

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def set_pieces
    fill_row(0, :black, BACK_ROW)
    fill_row(1, :black, FRONT_ROW)
    fill_row(6, :white, FRONT_ROW)
    fill_row(7, :white, BACK_ROW)

    self
  end

  def [](*pos)
    @board[pos.first][pos.last]
  end

  def []=(*pos, value)
    @board[pos.first][pos.last] = value
  end

  def in_check?(color)
    king_coords = pieces(color).select do |piece|
      piece.is_a?(King)
    end.first.pos

    opposing_pieces = color == :white ? pieces(:black) : pieces(:white)

    opposing_pieces.any? do |piece|
      piece.moves.include?(king_coords)
    end
  end

  def move(start_pos, end_pos)
    piece = self[*start_pos]

    piece.move_to(end_pos)
  end

  def dup
    dup_board = Board.new
    BOARD_SIZE.times do |rank_index|
      BOARD_SIZE.times do |file_index|
        dup_pos = [rank_index, file_index]
        next if self[*dup_pos].nil?
        self[*dup_pos].dup(dup_board)
      end
    end

    dup_board
  end

  def check_mate?(color)
    return false if !in_check?(color)

    pieces(color).all? do |piece|
      piece.valid_moves.empty?
    end
  end

  private

  def pieces(color)
    @board.flatten.compact.select do |piece|
      piece.color == color
    end
  end

  def fill_row(rank, color, piece_order)
    BOARD_SIZE.times do |file|
      piece_order[file].new(self, color, [rank,file])
    end

    nil
  end

end


class NoPieceError < StandardError
end

class InvalidMoveError < StandardError
end
