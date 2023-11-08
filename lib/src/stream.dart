import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'io.dart';
import 'task.dart' as T;

Stream<A> fromTask<A>(T.Task<A> task) =>
    FromCallableStream(() => task()).asBroadcastStream();

Stream<A> fromIO<A>(IO<A> io) => fromTask(T.fromIO(io));

Stream<C> combineLatest2<A, B, C>(
  Stream<A> a,
  Stream<B> b,
  C Function(A, B) mapper,
) =>
    ZipStream(
      [a, b],
      (values) => mapper(
        values[0] as A,
        values[1] as B,
      ),
    ).asBroadcastStream();

Stream<(A, B)> combineLatest2Tuple<A, B>(
  Stream<A> a,
  Stream<B> b,
) =>
    combineLatest2(a, b, (a, b) => (a, b));
