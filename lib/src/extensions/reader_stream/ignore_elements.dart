import '../../../reader_stream.dart' as RS;

extension IgnoreElementsStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, Never> ignoreElements() => RS.ignoreElements(this);
}
