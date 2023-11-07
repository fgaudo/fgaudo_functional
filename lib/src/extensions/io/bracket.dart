import '../../../io.dart' as I;

extension BracketIOExtension<A> on I.IO<A> {
  I.IO<B> bracket<B>({
    required I.IO<B> Function(A) use,
    required I.IO<void> Function(A) release,
  }) =>
      I.bracket(
        release: release,
        use: use,
      )(this);
}
