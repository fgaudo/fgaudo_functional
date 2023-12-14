import '../../../task.dart' as T;
import '../../../task_option.dart' as TO;

extension MapTaskOptionExtension<A> on TO.TaskOption<A> {
  TO.TaskOption<B> map<B>(
    B Function(A) mapper,
  ) =>
      TO.map(mapper)(this);
}

extension MatchTaskOptionExtension<A> on TO.TaskOption<A> {
  T.Task<B> match<B>({
    required B none,
    required B Function(A) some,
  }) =>
      TO.match(
        onNone: none,
        onSome: some,
      )(this);
}
