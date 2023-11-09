import '../../../reader.dart' as R;
import '../../../reader_stream.dart' as RS;

extension AsksReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, ENV2> asks<ENV2>(
    R.Reader<ENV, ENV2> f,
  ) =>
      RS.asks(f);
}
