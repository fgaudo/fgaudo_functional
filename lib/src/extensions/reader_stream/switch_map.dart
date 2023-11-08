import '../../../reader_stream.dart' as RS;

extension SwitchMapReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> switchMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      RS.switchMap(f)(this);
}
