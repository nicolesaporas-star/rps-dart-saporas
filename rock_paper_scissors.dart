import 'dart:io';

/// Gets the player's name and uses a default name if no name is entered.
String getPlayerName(String playerLabel, String defaultName) {
  stdout.write('Enter $playerLabel name: ');

  String? name = stdin.readLineSync();
  String trimmedName = name?.trim() ?? '';

  if (trimmedName.isEmpty) {
    return defaultName;
  }

  return trimmedName;
}

/// Checks whether a move is valid and returns it in lowercase.
String? validateMove(String input) {
  List<String> validMoves = ['rock', 'paper', 'scissors'];

  String move = input.trim().toLowerCase();

  if (validMoves.contains(move)) {
    return move;
  }

  return null;
}

/// Gets a valid move from the player.
String getMove(String playerName) {
  while (true) {
    stdout.write(
      '$playerName, enter your move (rock/paper/scissors): ',
    );

    String? input = stdin.readLineSync();
    String? move = validateMove(input ?? '');

    if (move != null) {
      return move;
    }

    print('Invalid move. Please type rock, paper, or scissors.');
  }
}

/// Determines the winner of the round based on both players' moves.
String? decideWinner(
  String player1Name,
  String player1Move,
  String player2Name,
  String player2Move,
) {
  if (player1Move == player2Move) {
    return null;
  }

  switch (player1Move) {
    case 'rock':
      if (player2Move == 'scissors') {
        return player1Name;
      } else {
        return player2Name;
      }

    case 'paper':
      if (player2Move == 'rock') {
        return player1Name;
      } else {
        return player2Name;
      }

    case 'scissors':
      if (player2Move == 'paper') {
        return player1Name;
      } else {
        return player2Name;
      }

    default:
      return null;
  }
}

void main() {
  print('===== ROCK, PAPER, SCISSORS =====');

  String player1Name = getPlayerName('Player 1', 'Player 1');
  String player2Name = getPlayerName('Player 2', 'Player 2');

  print('Hello, $player1Name and $player2Name!');

  int player1Score = 0;
  int player2Score = 0;
  int roundNumber = 1;

  String playAgain = 'n';

  do {
    print('\n--- Round $roundNumber ---');

    String player1Move = getMove(player1Name);

    for (int i = 0; i < 30; i++) {
      print('');
    }

    String player2Move = getMove(player2Name);

    print(
      '$player1Name chose $player1Move. '
      '$player2Name chose $player2Move.',
    );

    String? winner = decideWinner(
      player1Name,
      player1Move,
      player2Name,
      player2Move,
    );

    if (winner == player1Name) {
      player1Score++;
    } else if (winner == player2Name) {
      player2Score++;
    }

    print(
      'Result: ${winner == null ? "It\'s a draw!" : "$winner wins the round!"}',
    );

    print(
      'Score -> $player1Name: $player1Score | '
      '$player2Name: $player2Score',
    );

    stdout.write('Play again? (y/n): ');

    String? answer = stdin.readLineSync();

    playAgain = answer?.trim().toLowerCase() ?? 'n';

    if (playAgain == 'y') {
      roundNumber++;
    }
  } while (playAgain == 'y');

  print('\n===== FINAL SCORE =====');

  print('$player1Name: $player1Score | $player2Name: $player2Score');

  if (player1Score > player2Score) {
    print('Overall winner: $player1Name');
  } else if (player2Score > player1Score) {
    print('Overall winner: $player2Name');
  } else {
    print('Overall winner: It\'s a draw!');
  }
}