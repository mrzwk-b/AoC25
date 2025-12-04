import '../util.dart';

List<List<bool>> getData([String? inputFileName]) => 
  readInput(inputFileName).map(
    (line) => line.split('').map(
      (cell) => cell == '@'
    ).toList()
  ).toList()
;

bool isRollAccessible(Vector rollPosition, List<List<bool>> grid) {
  int totalAdjacent = 0;
  for (Vector direction in orthogonals + diagonals) {
    Vector adjacentPosition = rollPosition + direction;
    if (
      onGrid(adjacentPosition.row, adjacentPosition.col, grid) &&
      grid[adjacentPosition.row][adjacentPosition.col]
    ) {
      totalAdjacent += 1;
    }
  }
  return totalAdjacent < 4;
}

void main() {
  List<List<bool>> grid = getData();
  Stopwatch stopwatch = Stopwatch()..start();

  int totalAccessible = 0;
  for (int row = 0; row < grid.length; row += 1) {
    for (int col = 0; col < grid[0].length; col += 1) {
      if (grid[row][col] && isRollAccessible(Vector(row, col), grid)) {
        totalAccessible += 1;
      }
    }
  }

  stopwatch.stop();
  print(totalAccessible);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
  while (true);
}