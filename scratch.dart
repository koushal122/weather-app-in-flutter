import 'dart:io';
void main() async{
  task1();
  print(await task2());
  task3();
}

void task1(){
  String result="result of task1";
  print('Inside task1');
}

Future task2() async{
  Duration duration=Duration(seconds: 2);
  String result="";
  await Future.delayed(duration,(){
   result="result of task2";

  });
  return result;
}

void task3(){
  String result="result of task3";
  print('Inside task3');
}
