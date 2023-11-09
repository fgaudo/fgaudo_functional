import '../../../reader_io.dart' as RI;

extension AskReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, ENV> ask() => RI.ask();
}
