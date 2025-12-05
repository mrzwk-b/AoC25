import '../util.dart';

(List<(int, int)>, List<int>) getData(List<String> input) {
  int blankLineIndex = input.indexWhere((line) => line == '');
  return (
    input.sublist(0, blankLineIndex).map((line) {
      List<String> bounds = line.split('-');
      return (int.parse(bounds[0]), int.parse(bounds[1]));
    }).toList(),
    input.sublist(blankLineIndex + 1).map((line) => int.parse(line)).toList()
  );
}

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();

  var (List<(int, int)> ranges, List<int> values) = getData(input);
  int total = 0;
  for (int value in values) {
    for ((int, int) range in ranges) {
      if (value >= range.$1 && value <= range.$2) {
        total += 1;
        break;
      }
    }
  }

  stopwatch.stop();
  print(total);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}