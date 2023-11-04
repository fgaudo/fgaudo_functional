import '../../../option.dart' as O;

extension MapOptionExtension<A> on O.Option<A> {
  O.Option<B> map<B>(
    B Function(A) some,
  ) =>
      O.map(some)(this);
}
