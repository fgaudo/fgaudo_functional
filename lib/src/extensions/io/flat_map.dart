import '../../../io.dart' as I;

extension FlatMapIOExtension<A> on I.IO<A> {
  I.IO<B> flatMap<B>(
    I.IO<B> Function(A) f,
  ) =>
      I.flatMap(f)(this);
}
