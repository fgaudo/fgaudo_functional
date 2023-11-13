import '../../io.dart' as I;
import '../../reader.dart' as R;
import '../../reader_io.dart' as RI;

extension AskReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, ENV> ask() => RI.ask<ENV>().toReaderIOObj();
}

extension AsksReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      RI.asks(f).toReaderIOObj();
}

extension BracketReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, B> bracket<B>({
    required RI.ReaderIOObj<ENV, void> Function(A) release,
    required RI.ReaderIOObj<ENV, B> Function(A) use,
  }) =>
      RI
          .bracket(
            use: (A a) => use(a).call,
            release: (A a) => release(a).call,
          )(call)
          .toReaderIOObj();
}

extension FlatMapIOReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, B> flatMapIO<B>(
    I.IO<B> Function(A) f,
  ) =>
      RI.flatMapIO(f)(call).toReaderIOObj();
}

extension FlatMapReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, B> flatMap<B>(
    RI.ReaderIOObj<ENV, B> Function(A) f,
  ) =>
      RI
          .flatMap(
            (A a) => f(a).call,
          )(call)
          .toReaderIOObj();
}

extension MapReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RI.map(f)(call).toReaderIOObj();
}

extension SequenceArrayReaderIOObjExtension<ENV, A>
    on Iterable<RI.ReaderIOObj<ENV, A>> {
  RI.ReaderIOObj<ENV, Iterable<A>> sequenceArray() => RI
      .sequenceArray(
        map((obj) => obj.call),
      )
      .toReaderIOObj();
}

extension ToReaderReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  R.ReaderObj<ENV, I.IO<A>> toReader() => R.ReaderObj(call);
}

extension ToReaderIOObjReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIOObj<ENV, A> toReaderIOObj() => RI.ReaderIOObj(this);
}
