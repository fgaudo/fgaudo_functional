import '../../../io.dart' as I;
import '../../../reader_stream.dart' as RS;

extension DoOnDataIOStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnDataIO(
    I.IO<void> Function(A) f,
  ) =>
      RS.doOnDataIO(f)(this);
}
