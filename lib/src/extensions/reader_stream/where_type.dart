import '../../../reader_stream.dart' as RS;

extension WhereTypeReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, T> whereType<T>() => RS.whereType<T>()(this);
}
