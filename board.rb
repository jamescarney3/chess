require 'byebug'
class Board
  BOARD_SIZE = 8

  def initialize
    @board = Array.new(8) { Array.new(8) }
    #self.set_pieces
  end

  def set_pieces
    @board.each_with_index do |rank, rank_index|
      case rank_index
      when 0
        set_powers(rank_index, :black)
      when 1
        set_pawns(rank_index, :black)
      when 6
        set_pawns(rank_index, :white)
      when 7
        set_powers(rank_index, :white)
      end
    end

    self
  end

  def [](*pos)
    @board[pos.first][pos.last]
  end

  def []=(*pos, value)
    @board[pos.first][pos.last] = value
  end

  def in_check?(color)
    flat_board = @board.flatten
    king_coords = flat_board.select do |tile|
      tile.is_a?(King) && tile.color == color
    end.first.pos

    opposing_pieces = flat_board.select do |tile|
      tile.is_a?(Piece) && tile.color != color
    end

    opposing_pieces.any? do |piece|
        piece.moves.include?(king_coords)
    end

  end

  def move(start_pos, end_pos)
    piece = self[*start_pos]
    raise NoPieceError if piece.nil?
    raise InvalidMoveError unless piece.valid_moves.include?(end_pos)

    piece.move_to(end_pos)
  end

  def move!(start_pos, end_pos)
    piece = self[*start_pos]
    raise NoPieceError if piece.nil?
    raise InvalidMoveError unless piece.moves.include?(end_pos)

    piece.move_to(end_pos)
  end

  def dup
    dup_board = Board.new
    BOARD_SIZE.times do |rank_index|
      BOARD_SIZE.times do |file_index|
        dup_pos = [rank_index, file_index]
        next if self[*dup_pos].nil?
        dup_board[*dup_pos] = self[*dup_pos].dup(dup_board)
      end
    end

    dup_board
  end

  def check_mate?(color)
    return false if !in_check?(color)

    @board.flatten.select do |tile|
      !tile.nil? && tile.color == color
    end.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  private
  def set_pawns(rank_index, color)
    BOARD_SIZE.times do |file_index|
      pos = [rank_index, file_index]
      self[*pos] = Pawn.new(self, color, pos)
    end
  end

  def set_powers(rank_index, color)
    piece_classes = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    BOARD_SIZE.times do |file_index|
      pos = [rank_index, file_index]
      self[*pos] = piece_classes[file_index].new(self, color, pos)
    end

    self
  end

end


class NoPieceError < StandardError
end
