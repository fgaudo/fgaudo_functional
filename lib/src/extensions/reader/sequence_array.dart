import '../../../reader.dart' as R;

extension SequenceArrayReaderExtension<ENV, A> on Iterable<R.Reader<ENV, A>> {
  R.Reader<ENV, Iterable<A>> sequenceArray() => R.sequenceArray(this);
}
