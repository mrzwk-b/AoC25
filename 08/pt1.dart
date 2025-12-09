import 'dart:math';
import '../util.dart';

typedef coordinate = (int, int, int);

List<coordinate> formatData(List<String> input) => input.map((line) {
  List<int> coordinates = line.split(',').map((number) => int.parse(number)).toList();
  return (coordinates[0], coordinates[1], coordinates[2]);
}).toList();

Map<num, List<(coordinate, coordinate)>> getCoordinatePairsByDistance(List<coordinate> coordinates) {
  Map<num, List<(coordinate, coordinate)>> distances = {};
  for (int i = 0; i < coordinates.length; i += 1) {
    for (int j = i + 1; j < coordinates.length; j += 1) {
      distances.putIfAbsent(
        sqrt(
          pow(coordinates[i].$1 - coordinates[j].$1, 2) +
          pow(coordinates[i].$2 - coordinates[j].$2, 2) +
          pow(coordinates[i].$3 - coordinates[j].$3, 2)
        ), 
        () => [],
      ).add((coordinates[i], coordinates[j]));
    }
  }
  return distances;
}

void main() {
  List<String> input = readInput('test.txt');
  Stopwatch stopwatch = Stopwatch()..start();

  var boxCoordinates = formatData(input);
  var coordinatePairsByDistance = getCoordinatePairsByDistance(boxCoordinates);
  var sortedDistances = (coordinatePairsByDistance.keys.toList()..sort()).toList();
  Map<coordinate, Set<coordinate>> circuits = {
    for (var position in boxCoordinates) position : {position}
  };
  for (int i = 0; i < 10;) {
    var pairs = coordinatePairsByDistance[sortedDistances[i]]!;
    for (var pair in pairs) {
      if (i < 10) {
        print('connecting ${pair.$1} and ${pair.$2}');
        circuits[pair.$1] = circuits[pair.$2]!..add(pair.$1);
        i += 1;
      }
    }
  }
  int summary = (circuits.values
  .map((circuit) => circuit.length)
  .toSet()
  .toList()
  ..sort((a, b) => -(a.compareTo(b)))
  ).take(3).reduce((a, b) => a * b);

  stopwatch.stop();
  print(summary);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}