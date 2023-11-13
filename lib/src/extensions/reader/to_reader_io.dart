import '../../../io.dart';
import '../../../reader.dart' as R;
import '../../../reader_io.dart' as RI;

extension ToReaderIOReaderExtension<ENV, A> on R.Reader<ENV, IO<A>> {
  RI.ReaderIOObj<ENV, A> toReaderIO() => RI.ReaderIOObj(call);
}
