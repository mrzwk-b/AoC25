import 'dart:math';
import '../util.dart';

List<int> getColumnBoundaries(List<String> input) => [
  -1,
  for (int col = 0; col < input[0].length; col += 1)
    if (input.every((row) => row[col] == ' ')) col
  ,
  input.map((line) => line.length).reduce((a, b) => max(a, b)),
];

List<(List<int>, int Function(int, int))> formatData(List<String> input) {
  List<int> columnBoundaries = getColumnBoundaries(input);
  return [
    for (int i = 1; i < columnBoundaries.length; i += 1) (
      input.sublist(0, input.length - 1).map((line) =>
        int.parse(line.substring(columnBoundaries[i-1] + 1, columnBoundaries[i]).replaceAll(' ', ''))
      ).toList(),
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