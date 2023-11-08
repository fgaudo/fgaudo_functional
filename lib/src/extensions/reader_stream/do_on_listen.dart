import '../../../reader_stream.dart' as RS;
import '../../reader_io.dart' as RIO;

extension DoOnListenReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnListen(
    RIO.ReaderIO<ENV, void> f,
  ) =>
      RS.doOnListen(f)(this);
}
