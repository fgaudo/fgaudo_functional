import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../io/io.dart';
import '../task/task.dart' as T;

Stream<A> fromTask<A>(T.Task<A> t) =>
    FromCallableStream(() => t(), reusable: true);

Stream<A> fromIO<A>(IO<A> io) => fromTask(
      T.fromIO(() => io()),
    );
