// ignore_for_file: unused_import

import 'dart:mirrors';

import 'package:ansi_styles/ansi_styles.dart';
import 'package:functionally/builders.dart';
import 'package:functionally/common.dart';
import 'package:functionally/either.dart';
import 'package:functionally/io.dart';
import 'package:functionally/option.dart';
import 'package:functionally/reader.dart';
import 'package:functionally/reader_io.dart';
import 'package:functionally/reader_stream.dart';
import 'package:functionally/reader_task.dart';
import 'package:functionally/stream.dart';
import 'package:functionally/stream_either.dart';
import 'package:functionally/stream_option.dart';
import 'package:functionally/task.dart';
import 'package:functionally/task_either.dart';
import 'package:functionally/task_option.dart';

void checkMethods(Type t, List<String> methods) {
  final clazz = reflectClass(t);
  final missing = methods
      .map(
        (method) => (method, clazz.declarations.containsKey(Symbol(method))),
      )
      .where((element) => !element.$2)
      .map((e) => e.$1)
      .join(', ');

  if (missing.isNotEmpty) {
    print(
        '${AnsiStyles.bold(MirrorSystem.getName(clazz.simpleName))} is missing ${AnsiStyles.bold(missing)}');
  }
}

void main() {
  checkMethods(EitherBuilder, ['map', 'flatMap', 'match']);
  checkMethods(OptionBuilder, ['map', 'flatMap', 'match']);
  checkMethods(IOBuilder, ['map', 'flatMap']);
  checkMethods(TaskBuilder, ['map', 'flatMap']);
  checkMethods(TaskEitherBuilder, ['map', 'flatMap', 'match']);
  checkMethods(ReaderBuilder, ['map', 'flatMap']);
  checkMethods(ReaderIOBuilder, ['map', 'flatMap']);
  checkMethods(ReaderStreamBuilder, ['map', 'flatMap']);
  checkMethods(ReaderTaskBuilder, ['map', 'flatMap']);
  checkMethods(StreamOptionBuilder, ['map', 'flatMap', 'match']);
  checkMethods(
      StreamEitherBuilder, ['map', 'flatMap', 'doOnLeft', 'doOnRight']);
  checkMethods(TaskOptionBuilder, ['map', 'flatMap', 'match']);
}
