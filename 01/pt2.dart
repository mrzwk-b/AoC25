import '../util.dart';
import 'pt1.dart';

void main() {
  List<String> input = readInput();
  Stopwatch stopwatch = Stopwatch()..start();
  
  int dialValue = 50;
  int zeros = 0;
  for (Rotation rotation in formatData(input)) {
    int newDialValue = rotate(dialValue, rotation);
    zeros += 
      ((rotation.distance ~/ 100) - (rotation.distance % 100 == 0 ? 1 : 0)) +
      (dialValue == 0 ? 0 : (rotation.isLeft
        ? (rotation.distance % 100 >= dialValue ? 1 : 0)
        : (rotation.distance % 100 + dialValue >= 100 ? 1 : 0)
      ))
    ;
    dialValue = newDialValue;
  }
  
  stopwatch.stop();
  print(zeros);
  print('ran in ${stopwatch.elapsedMicroseconds} microseconds');
}