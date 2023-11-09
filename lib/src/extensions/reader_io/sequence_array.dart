import '../../../io.dart' as I;
import '../../../reader.dart' as R;
import '../../../reader_io.dart' as RI;

extension SequenceArrayReaderIOExtension<ENV, A>
    on Iterable<RI.ReaderIO<ENV, A>> {
  RI.ReaderIO<ENV, Iterable<A>> sequenceArray() => RI.sequenceArray(this);

  R.Reader<ENV, Iterable<I.IO<A>>> reader_sequenceArray() =>
      R.sequenceArray(this);
}
