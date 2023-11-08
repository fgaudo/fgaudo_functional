import '../../../reader_stream.dart' as RS;

extension SwitchMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> switchMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.switchMapStream(f)(this);
}
