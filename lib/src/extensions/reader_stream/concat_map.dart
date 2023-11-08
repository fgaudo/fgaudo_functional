import '../../../reader_stream.dart' as RS;

extension ConcatMapReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> concatMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      RS.concatMap(f)(this);
}
