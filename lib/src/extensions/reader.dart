import '../../../io.dart' as I;
import '../../../reader.dart' as R;
import '../../../reader_io.dart' as RIO;
import '../../../reader_stream.dart' as RS;

extension AskReaderExtension<ENV, A> on R.ReaderObj<ENV, A> {
  R.ReaderObj<ENV, ENV> ask() => R.ask<ENV>().toReaderObj();
}

extension AsksReaderExtension<ENV, A> on R.ReaderObj<ENV, A> {
  R.ReaderObj<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      R.asks(f.call).toReaderObj();
}

extension FlatMapReaderExtension<ENV, A> on R.ReaderObj<ENV, A> {
  R.ReaderObj<ENV, B> flatMap<B>(
    R.ReaderObj<ENV, B> Function(A) f,
  ) =>
      R.flatMap((A a) => f(a).call)(call).toReaderObj();
}

extension LocalReaderExtension<ENV1, A> on R.ReaderObj<ENV1, A> {
  R.ReaderObj<ENV2, A> local<ENV2>(
    ENV1 Function(ENV2) f,
  ) =>
      R.local(f)(call).toReaderObj();
}

extension MapReaderExtension<ENV, A> on R.ReaderObj<ENV, A> {
  R.ReaderObj<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      R.map(f)(call).toReaderObj();
}

extension ToReaderIOReaderExtension<ENV, A> on R.ReaderObj<ENV, I.IO<A>> {
  RIO.ReaderIOObj<ENV, A> toReaderIO() => RIO.ReaderIOObj(call);
}

extension ToReaderStreamReaderExtension<ENV, A> on R.ReaderObj<ENV, Stream<A>> {
  RS.ReaderStreamObj<ENV, A> toReaderStream() => RS.ReaderStreamObj(call);
}

extension ToReaderObjReaderExtension<ENV, A> on R.Reader<ENV, A> {
  R.ReaderObj<ENV, A> toReaderObj() => R.ReaderObj(call);
}
