import '../../../reader_io.dart' as RI;

extension SequenceArrayReaderIOExtension<ENV, A>
    on Iterable<RI.ReaderIO<ENV, A>> {
  RI.ReaderIO<ENV, Iterable<A>> sequenceArray() => RI.sequenceArray(this);
}
