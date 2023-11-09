import '../../../reader.dart' as R;
import '../../../reader_io.dart' as RI;

extension AsksReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, ENV2> asks<ENV2>(
    R.Reader<ENV, ENV2> f,
  ) =>
      RI.asks(f);
}
