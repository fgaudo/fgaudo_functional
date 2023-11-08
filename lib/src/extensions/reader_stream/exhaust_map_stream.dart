import '../../../reader_stream.dart' as RS;

extension ExhaustMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> exhaustMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.exhaustMapStream(f)(this);
}
