import '../../../stream_option.dart' as SO;

final class StreamOptionBuilder<A> {
  const StreamOptionBuilder(this._f);

  final SO.StreamOption<A> _f;

  SO.StreamOption<A> build() => _f;

  StreamOptionBuilder<B> map<B>(
    B Function(A) mapper,
  ) =>
      StreamOptionBuilder(SO.map(mapper)(_f));

  Stream<B> match<B>({
    required B none,
    required B Function(A) some,
  }) =>
      SO.match(
        onNone: none,
        onSome: some,
      )(_f);
}

extension ToStreamOptionBuilderReaderExtension<A> on SO.StreamOption<A> {
  StreamOptionBuilder<A> toStreamOptionBuilder() => StreamOptionBuilder(this);
}
