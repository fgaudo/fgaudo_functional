import '../../../reader_stream.dart' as RS;

extension FlatMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> flatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.flatMapStream(f)(this);
}
