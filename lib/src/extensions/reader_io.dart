import '../../io.dart' as I;
import '../../reader.dart' as R;
import '../../reader_io.dart' as RI;

extension AskReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, ENV> ask() => RI.ask();
}

extension AsksReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      RI.asks(f);
}

extension BracketReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> bracket<B>({
    required RI.ReaderIO<ENV, void> Function(A) release,
    required RI.ReaderIO<ENV, B> Function(A) use,
  }) =>
      RI.bracket(
        use: use,
        release: release,
      )(this);
}

extension FlatMapIOReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> flatMapIO<B>(
    I.IO<B> Function(A) f,
  ) =>
      RI.flatMapIO(f)(this);
}

extension FlatMapReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> flatMap<B>(
    RI.ReaderIO<ENV, B> Function(A) f,
  ) =>
      RI.flatMap(f)(this);
}

extension MapReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RI.map(f)(this);
}

extension ToReaderReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  R.Reader<ENV, I.IO<A>> toReader() => R.Reader(call);
}
