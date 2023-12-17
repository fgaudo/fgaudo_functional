import 'dart:mirrors';

import 'package:functionally/builders.dart';
import 'package:functionally/common.dart';
import 'package:functionally/either.dart';
import 'package:functionally/io.dart';
import 'package:functionally/option.dart';
import 'package:functionally/reader.dart';
import 'package:functionally/reader_io.dart';
import 'package:functionally/reader_task.dart';
import 'package:functionally/reader_stream.dart';
import 'package:functionally/stream.dart';
import 'package:functionally/stream_either.dart';
import 'package:functionally/stream_option.dart';
import 'package:functionally/task.dart';
import 'package:functionally/task_either.dart';
import 'package:functionally/task_option.dart';

const functor = ['map'];
const monad = ['flatMap'];

void main() {
  final se = reflectClass(StreamEitherBuilder);
  print(se.declarations.containsKey(Symbol('map')));
}
