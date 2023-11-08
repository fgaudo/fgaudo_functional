import '../../../reader_stream.dart' as RS;

extension StartWithReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> startWith(
    A a,
  ) =>
      RS.startWith(a)(this);
}
