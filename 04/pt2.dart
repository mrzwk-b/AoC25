import 'pt1.dart';
import '../util.dart';

void main() {
  List<List<bool>> grid = getData();
  Stopwatch stopwatch = Stopwatch()..start();

  int totalRemoved = 0;
  int removedThisCycle = -1;
  while (removedThisCycle != 0) {
    removedThisCycle = 0;
    for (int row = 0; row < grid.length; row += 1) {
      for (int col = 0; col < grid[0].length; col += 1) {
        if (grid[row][col] && isRollAccessible(Vector(row, col), grid)) {
          grid[row][col] = false;
          removedThisCycle += 1;
          totalRemoved += 1;
        }
      }
    }
  }
  
  stopwatch.stop();
  print(totalRemoved);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}