import 'dart:math';

import '../util.dart';
import 'pt1.dart';

class RangeCollection {
  List<(int, int)> ranges;
  RangeCollection(): ranges = [];
  RangeCollection.fromEntries(List<(int, int)> entries): ranges = [] {
    for ((int, int) range in entries) {
      addRange(range);
    }
  }

  void collateRanges() {
    Map<int, Set<int>> overlapIndexes = {};
    // get all ranges with overlap
    for (int i = 0; i < ranges.length; i += 1) {
      overlapIndexes.putIfAbsent(i, () => {});
      for (int j = i + 1; j < ranges.length; j += 1) {
        overlapIndexes.putIfAbsent(j, () => {});
        if (
          // j's start is included in i
          (ranges[i].$1 <= ranges[j].$1 && ranges[i].$2 >= ranges[j].$1) ||
          // j's end is included in i
          (ranges[i].$1 <= ranges[j].$2 && ranges[i].$2 >= ranges[j].$2) ||
          // i's start is included in j
          (ranges[j].$1 <= ranges[i].$1 && ranges[j].$2 >= ranges[i].$1) ||
          // i's end is included in j
          (ranges[j].$1 <= ranges[i].$2 && ranges[j].$2 >= ranges[i].$2) ||
          // i ends as j begins
          (ranges[i].$2 == ranges[j].$1 - 1) ||
          // j ends as i begins
          (ranges[j].$2 == ranges[i].$1 - 1)
        ) {
          overlapIndexes[i]!.add(j);
          overlapIndexes[j]!.add(i);
        }
      }
    }
    // get all groups of overlapping ranges
    List<Set<int>> indexSetsToMerge = [];
    while (overlapIndexes.length > 0) {
      int initialIndex = overlapIndexes.keys.first;
      Set<int> connectionsFound = {initialIndex};
      List<int> connectionsToSearch = [initialIndex];
      while (connectionsToSearch.length > 0) {
        Set<int> connections = overlapIndexes.remove(connectionsToSearch.removeLast())!;
        for (int connection in connections) {
          if (!connectionsFound.contains(connection)) {
            connectionsFound.add(connection);
            connectionsToSearch.add(connection);
          }
        }
      }
      indexSetsToMerge.add(connectionsFound);
    }
    // merge groups
    ranges = [for (Set<int> indexSet in indexSetsToMerge) (
      indexSet.map((index) => ranges[index].$1).reduce((a, b) => min(a, b)),
      indexSet.map((index) => ranges[index].$2).reduce((a, b) => max(a, b))
    )];
  }

  void addRange((int, int) range) {
    ranges.add(range);
    collateRanges();
  }
}

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();

  int total = 0;
  for ((int, int) range in RangeCollection.fromEntries(getData(input).$1).ranges) {
    total += (range.$2 - range.$1) + 1;
  }

  stopwatch.stop();
  print(total);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}