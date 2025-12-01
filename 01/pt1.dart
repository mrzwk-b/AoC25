import '../util.dart';

typedef Rotation = ({bool isLeft, int distance});

List<Rotation> getData([String inputFileName = 'input.txt']) => 
  readInput(inputFileName).map((line) => 
    (isLeft: line.startsWith('L'), distance: int.parse(line.substring(1)))
  ).toList()
;

int rotate(int dialValue, Rotation rotation) =>
  (dialValue + (rotation.distance * (rotation.isLeft ? -1 : 1))) % 100
;

void main() {
  int dialValue = 50;
  int zeros = 0;
  for (Rotation rotation in getData()) {
    dialValue = rotate(dialValue, rotation);
    if (dialValue == 0) {
      zeros += 1;
    }
  }
  print(zeros);
}