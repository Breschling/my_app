//Copyright (c) 2023, dido GmbH
//All rights reserved.
import 'dart:io';
import 'package:async/async.dart';

Future<void> main(List<String> args) async {
  experiment5();
}

void experiment5() async{
  final s1 = evenStream2();
  final  s2 = oddStream2();
  final sq1 = StreamQueue(s1);
  final sq2 = StreamQueue(s2);

  int num1 = 0;
  int num2 = 0;
  while(await sq1.hasNext || await sq2.hasNext) {
    List<int> v1 = [];
    List<int> v2 = [];
    if (await sq1.hasNext && num1 <= num2) {
      v1 =  await sq1.next;
      num1 = num1 + v1.length;
    }
    if (await sq2.hasNext  && num2 <= num1) {
      v2 =  await sq2.next;
      num2 = num2 + v2.length;
    }
    print('V1: $v1, V2: $v2');
  }
}

void experiment4() async{
  final s1 = evenStream2();
  final  s2 = oddStream2();
  final s3 = StreamZip([s1, s2]);
  await for(var val in s3) {
    print(val.toString());
  }
}

void experiment3() async{
  final s1 = evenStream2();
  final  s2 = oddStream2();
  final s3 = StreamGroup.merge([s1, s2]);
  await for(var val in s3) {
    print(val.toString());
  }
}

Stream<List<int>> evenStream2() async* {
  yield [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,];
  sleep(Duration(microseconds: 100));
  yield [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,];
  sleep(Duration(microseconds: 100));
}

Stream<List<int>> oddStream2() async* {
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
  yield [1, 1];
  sleep(Duration(microseconds: 100));
}

void experiment2() async{
  final  s2 = oddStream().slices(2);
  await Future.delayed(Duration(seconds: 1));
  final  s1 = evenStream().expand((e) => e).slices(2);
  final s3 = StreamGroup.merge([s1, s2]);
  await for(var val in s3) {
    print(val.toString());
  }
}

void experiment1() async{
  print('hi');
  int max = 100000;
  var s2 = stream(1, 2, max, const Duration(microseconds: 1));
  var s1 = stream(0, 2, max, const Duration(milliseconds: 1000)); //microseconds: 1

  var s3 = StreamGroup.merge([s1, s2]);
  await for(int val in s3) {
    print(val);
  }
}

Stream<List<int>> evenStream() async* {
  yield [0, 2,];
  sleep(Duration(seconds: 1));
  yield [4];
  sleep(Duration(seconds: 1));
  yield [6, 8];
  sleep(Duration(seconds: 1));
}

Stream<int> oddStream() async* {
  yield 1;
  sleep(Duration(seconds: 1));
  yield 3;
  sleep(Duration(seconds: 1));
  yield 5;
  sleep(Duration(seconds: 1));
  yield 7;
  sleep(Duration(seconds: 1));
  yield 9;
  sleep(Duration(seconds: 1));
}

Stream<int> stream(int start, int step, int end, Duration d) async* {
  int i = start;
  while(i <= end) {
    yield i;
    print('$start: generated $i');
    i = i + step;
    sleep(d);
  }
}