import '../../../reader_stream.dart' as RS;

extension ConcatMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> concatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.concatMapStream(f)(this);
}
