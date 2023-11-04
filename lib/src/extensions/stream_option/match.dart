import '../../../stream_option.dart' as SO;

extension MatchStreamOptionExtension<A> on SO.StreamOption<A> {
  Stream<B> map<B>({
    required B none,
    required B Function(A) some,
  }) =>
      SO.match(
        onNone: none,
        onSome: some,
      )(this);
}
