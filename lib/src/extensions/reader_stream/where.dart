import '../../../reader_stream.dart' as RS;

extension WhereReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> where(bool Function(A) predicate) =>
      RS.where(predicate)(this);
}
