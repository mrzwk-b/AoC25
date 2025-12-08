import 'dart:math';

import '../util.dart';

List<(int, int, int)> formatData(List<String> input) => input.map((line) {
  List<int> coordinates = line.split(',').map((number) => int.parse(number)).toList();
  return (coordinates[0], coordinates[1], coordinates[2]);
}).toList();

Map<int, Iterable<Iterable<(int, int, int)>>> getAllDistances(List<(int, int, int)> coordinates) {
  Map<int, Iterable<Iterable<(int, int, int)>>> distances = {};
  for (int i = 0; i < coordinates.length; i += 1) {
    for (int j = i; j < coordinates.length; j += 1) {
      distances.putIfAbsent(
        sqrt(
          pow(coordinates[i].$1 - coordinates[j].$1, 2)

        ).toInt(), 
        )
    }
  }
}

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();

  List<(int, int, int)> boxCoordinates = formatData(input);


  stopwatch.stop();
  print(null);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}