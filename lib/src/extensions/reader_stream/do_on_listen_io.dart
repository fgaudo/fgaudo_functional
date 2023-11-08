import '../../../io.dart' as I;
import '../../../reader_stream.dart' as RS;

extension DoOnListenIOReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnListenIO(
    I.IO<void> f,
  ) =>
      RS.doOnListenIO(f)(this);
}
