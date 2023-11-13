import '../../../reader_stream.dart' as RS;

extension MapReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RS.map(f)(this);
}
