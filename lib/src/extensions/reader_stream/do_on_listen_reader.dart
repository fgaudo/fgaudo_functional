import '../../../reader_stream.dart' as RS;
import '../../reader_io.dart' as RIO;

extension DoOnListenReaderReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnListenReader(
    RIO.ReaderIO<ENV, void> f,
  ) =>
      RS.doOnListenReader(f)(this);
}
