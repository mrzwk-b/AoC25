import '../util.dart';
import 'pt1.dart';

List<(List<int>, int Function(int, int))> formatData(List<String> input) {
  List<int> columnBoundaries = getColumnBoundaries(input);
  return [
    for (int i = 1; i < columnBoundaries.length; i += 1) (
      [
        for (int col = columnBoundaries[i] - 1; col > columnBoundaries[i-1]; col -= 1)
          int.parse(
            input
            .sublist(0, input.length - 1)
            .map((line) => line[col])
            .where((char) => char != ' ')
            .join()
          )
        ,
      ],
      input.last.substring(columnBoundaries[i-1] + 1, columnBoundaries[i]).replaceAll(' ', '') == '+'
        ? (a, b) => a + b
        : (a, b) => a * b
      ,
    ),
  ];
}

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();

  List<(List<int>, int Function(int, int))> problems = formatData(input);
  int total = problems.map((problem) => problem.$1.reduce(problem.$2)).reduce((a, b) => a + b);

  stopwatch.stop();
  print(total);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}