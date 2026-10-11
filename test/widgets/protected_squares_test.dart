import 'package:dartchess/dartchess.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lichess_mobile/src/widgets/board.dart';

void main() {
  group('protectedSquares', () {
    test('pawn defends the knight in front of it diagonally', () {
      // White knight on d4, white pawn on e3, kings far away.
      final squares = protectedSquares('7k/8/8/8/3N4/4P3/8/K7 w - - 0 1', Side.white);
      expect(squares.has(Square.d4), isTrue);
      // A pawn does not defend the square straight in front of it.
      expect(squares.has(Square.e4), isFalse);
    });

    test('queen lines stop at the first blocking piece', () {
      // White queen on a1, own pawn on d4 blocks the diagonal.
      final squares = protectedSquares('7k/8/8/8/3P4/8/8/Q6K w - - 0 1', Side.white);
      expect(squares.has(Square.b2), isTrue);
      expect(squares.has(Square.c3), isTrue);
      expect(squares.has(Square.d4), isTrue); // the blocker itself is defended
      expect(squares.has(Square.e5), isFalse); // behind the blocker
      expect(squares.has(Square.a8), isTrue); // open file
    });

    test('only counts pieces of the requested side', () {
      final squares = protectedSquares('7k/8/8/8/8/8/8/K7 w - - 0 1', Side.black);
      expect(squares.has(Square.g7), isTrue);
      expect(squares.has(Square.b2), isFalse);
    });

    test('returns empty set on invalid fen', () {
      expect(protectedSquares('not a fen', Side.white), SquareSet.empty);
    });
  });
}
