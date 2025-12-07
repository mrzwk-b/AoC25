import '../util.dart';

(List<List<bool>>, int) formatData(List<String> input) => (
  input.map(
    (line) => line.split('').map(
      (cell) => cell == '^'
    ).toList()
  ).toList(),
  input[0].indexOf('S'),
);

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();

  var (List<List<bool>> grid, int start) = formatData(input);
  int totalSplits = 0;
  List<bool> beams = [for (int i = 0; i < grid[0].length; i += 1) i == start];
  for (int row = 1; row < grid.length; row += 1) {
    List<bool> nextRowBeams = [for (int i = 0; i < beams.length; i += 1) false];
    for (int col = 0; col < grid[row].length; col += 1) {
      if (beams[col]) {
        if (grid[row][col]) {
          totalSplits += 1;
          nextRowBeams[col - 1] = true;
          nextRowBeams[col + 1] = true;
        }
        else {
          nextRowBeams[col] = true;
        }
      }
    }
    beams = nextRowBeams;
  }

  stopwatch.stop();
  print(totalSplits);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}