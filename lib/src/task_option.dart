import '../task.dart' as T;
import 'option.dart' as O;

typedef TaskOption<A> = Future<O.Option<A>> Function();

T.Task<B> Function(
  TaskOption<A>,
) match<A, B>({
  required B onNone,
  required B Function(A) onSome,
}) =>
    (taskOption) => () => taskOption().then(
          O.match(
            onNone: onNone,
            onSome: onSome,
          ),
        );

TaskOption<B> Function(
  TaskOption<A>,
) map<A, B>(
  B Function(A) onSome,
) =>
    (taskOption) => () => taskOption().then(
          O.map(onSome),
        );
