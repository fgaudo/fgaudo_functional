import '../task/task.dart';

Stream<A> fromTask<A>(Task<A> t) => Stream.fromFuture(t());
