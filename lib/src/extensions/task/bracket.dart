import '../../../task.dart' as T;

extension BracketTaskExtension<A> on T.Task<A> {
  T.Task<B> bracket<B>({
    required T.Task<B> Function(A) use,
    required T.Task<void> Function(A) release,
  }) =>
      T.bracket(
        release: release,
        use: use,
      )(this);
}
