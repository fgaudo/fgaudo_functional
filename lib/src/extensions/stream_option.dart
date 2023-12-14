import '../../../stream_option.dart' as SO;

extension MapStreamOptionExtension<A> on SO.StreamOption<A> {
  SO.StreamOption<B> map<B>(
    B Function(A) mapper,
  ) =>
      SO.map(mapper)(this);
}

extension MatchStreamOptionExtension<A> on SO.StreamOption<A> {
  Stream<B> match<B>({
    required B none,
    required B Function(A) some,
  }) =>
      SO.match(
        onNone: none,
        onSome: some,
      )(this);
}
