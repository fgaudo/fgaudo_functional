import '../../../io.dart' as I;
import '../../../reader_stream.dart' as RS;

extension DoOnListenReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnListen(
    I.IO<void> f,
  ) =>
      RS.doOnListen(f)(this);
}
