import '../../../reader.dart' as R;
import '../../../reader_stream.dart' as RS;

extension ToReaderStreamReaderExtension<ENV, A> on R.Reader<ENV, Stream<A>> {
  RS.ReaderStream<ENV, A> toReaderStream() => RS.ReaderStream(call);
}
