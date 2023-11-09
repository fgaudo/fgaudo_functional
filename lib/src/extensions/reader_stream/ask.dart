import '../../../reader_stream.dart' as RS;

extension AskReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, ENV> ask() => RS.ask();
}
