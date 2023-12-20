import 'dart:async';

import 'package:rxdart/streams.dart';
import 'package:rxdart/transformers.dart';

import 'io.dart';
import 'task.dart' as T;

Stream<A> fromTask<A>(T.Task<A> task, {bool reusable = false}) =>
    FromCallableStream(task, reusable: reusable);

Stream<A> fromIO<A>(IO<A> io, {bool reusable = false}) =>
    fromTask(T.fromIO(io), reusable: reusable);

Stream<A> fromValue<A>(A a, {bool reusable = false}) =>
    fromTask(() async => a, reusable: reusable);

Stream<A> fromIterable<A>(Iterable<A> list, {bool reusable = false}) =>
    fromTask(() async => list, reusable: reusable).flatMap(Stream.fromIterable);
