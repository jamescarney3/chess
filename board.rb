require_relative 'pieces.rb'
require_relative 'chess.rb'

class Board
  BOARD_SIZE = 8

  def initialize
    @board = Array.new(8) { Array.new(8) }
  end

  def [](*pos)
    @board[pos.first][pos.last]
  end

  def []=(*pos, value)
    @board[pos.first][pos.last] = value
  end

end
