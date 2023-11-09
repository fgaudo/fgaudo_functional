import '../../../reader.dart' as R;

extension AskReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.Reader<ENV, ENV> ask() => R.ask();
}
