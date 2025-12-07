import '../util.dart';
import 'pt1.dart';

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();

  var (List<List<bool>> grid, int start) = formatData(input);
  List<int> splitCounts = [for (int i = 0; i < grid[0].length; i += 1) 1];
  for (int row = grid.length - 2; row >= 0; row -= 1) {
    splitCounts = [
      for (int col = 0; col < grid[row].length; col += 1) 
        (grid[row][col]
          ? splitCounts[col - 1] + splitCounts[col + 1]
          : splitCounts[col]
        )
      ,
    ];
  }

  stopwatch.stop();
  print(splitCounts[start]);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}