import '../../../task.dart';
import '../../../task_option.dart' as TO;

extension MatchTaskOptionExtension<A> on TO.TaskOption<A> {
  Task<B> match<B>({
    required B none,
    required B Function(A) some,
  }) =>
      TO.match(
        onNone: none,
        onSome: some,
      )(this);
}
