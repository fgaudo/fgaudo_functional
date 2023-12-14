import '../../../stream_option.dart' as SO;

final class StreamOption<A> {
  const StreamOption(this._f);

  final SO.StreamOption<A> _f;

  StreamOption<B> map<B>(
    B Function(A) mapper,
  ) =>
      StreamOption(SO.map(mapper)(_f));

  Stream<B> match<B>({
    required B none,
    required B Function(A) some,
  }) =>
      SO.match(
        onNone: none,
        onSome: some,
      )(_f);
}
