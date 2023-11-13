import '../../../reader.dart' as R;
import '../../../reader.dart';
import '../../../reader_stream.dart' as RS;

extension ToReaderReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  R.Reader<ENV, Stream<A>> toReader() => Reader(call);
}
