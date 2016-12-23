require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @parent = nil
    @children = []
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves_available = []
    board.rows.each_index do |row_i|
      board.rows[row_i].each_index do |col_i|
        new_pos = [row_i, col_i]
        if board[new_pos].nil?
          if next_mover_mark == :x
            child_next_mover_mark =:o
          else
            child_next_mover_mark = :x
          end
          child_board = board.dup
          child_board[new_pos] = next_mover_mark
          moves_available << TicTacToeNode.new(child_board, child_next_mover_mark, new_pos)
        end
      end
    end
    moves_available
  end
end
