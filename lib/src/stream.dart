import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'io.dart';
import 'task.dart' as T;

Stream<A> fromTask<A>(T.Task<A> task) =>
    FromCallableStream(task, reusable: true);

Stream<A> fromIO<A>(IO<A> io) => fromTask(
      T.fromIO(io),
    );
