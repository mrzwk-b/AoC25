import '../util.dart';

typedef Rotation = ({bool isLeft, int distance});

List<Rotation> formatData(List<String> input) => 
  input.map((line) => 
    (isLeft: line.startsWith('L'), distance: int.parse(line.substring(1)))
  ).toList()
;

int rotate(int dialValue, Rotation rotation) =>
  (dialValue + (rotation.distance * (rotation.isLeft ? -1 : 1))) % 100
;

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();

  int dialValue = 50;
  int zeros = 0;
  for (Rotation rotation in formatData(input)) {
    dialValue = rotate(dialValue, rotation);
    if (dialValue == 0) {
      zeros += 1;
    }
  }
  
  stopwatch.stop();
  print(zeros);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}