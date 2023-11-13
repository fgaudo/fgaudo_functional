import '../../../io.dart' as I;
import '../../../reader.dart' as R;
import '../../../reader_io.dart' as RIO;
import '../../../reader_stream.dart' as RS;

extension AskReaderExtension<ENV, A> on R.ReaderObj<ENV, A> {
  R.ReaderObj<ENV, ENV> ask() => R.ReaderObj(R.ask());
}

extension AsksReaderExtension<ENV, A> on R.ReaderObj<ENV, A> {
  R.ReaderObj<ENV, ENV2> asks<ENV2>(
    R.ReaderObj<ENV, ENV2> f,
  ) =>
      R.ReaderObj(
        R.asks(f.call),
      );
}

extension FlatMapReaderExtension<ENV, A> on R.ReaderObj<ENV, A> {
  R.ReaderObj<ENV, B> flatMap<B>(
    R.ReaderObj<ENV, B> Function(A) f,
  ) =>
      R.ReaderObj(
        R.flatMap((A a) => f(a).call)(call),
      );
}

extension LocalReaderExtension<ENV1, A> on R.ReaderObj<ENV1, A> {
  R.ReaderObj<ENV2, A> local<ENV2>(
    ENV1 Function(ENV2) f,
  ) =>
      R.ReaderObj(
        R.local(f)(call),
      );
}

extension MapReaderExtension<ENV, A> on R.ReaderObj<ENV, A> {
  R.ReaderObj<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      R.ReaderObj(
        R.map(f)(call),
      );
}

extension SequenceArrayReaderExtension<ENV, A>
    on Iterable<R.ReaderObj<ENV, A>> {
  R.ReaderObj<ENV, Iterable<A>> sequenceArray() => R.ReaderObj(
        R.sequenceArray(
          map((r) => r.call),
        ),
      );
}

extension ToReaderIOReaderExtension<ENV, A> on R.ReaderObj<ENV, I.IO<A>> {
  RIO.ReaderIOObj<ENV, A> toReaderIO() => RIO.ReaderIOObj(call);
}

extension ToReaderStreamReaderExtension<ENV, A> on R.ReaderObj<ENV, Stream<A>> {
  RS.ReaderStreamObj<ENV, A> toReaderStream() => RS.ReaderStreamObj(call);
}
