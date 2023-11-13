import '../../io.dart' as I;
import '../../reader.dart' as R;
import '../../reader_io.dart' as RI;

extension AskReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, ENV> ask() => RI.ReaderIOObj(RI.ask<ENV>());
}

extension AsksReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, ENV2> asks<ENV2>(
    ENV2 Function(ENV) f,
  ) =>
      RI.ReaderIOObj(
        RI.asks(f),
      );
}

extension BracketReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, B> bracket<B>({
    required RI.ReaderIOObj<ENV, void> Function(A) release,
    required RI.ReaderIOObj<ENV, B> Function(A) use,
  }) =>
      RI.ReaderIOObj(
        RI.bracket(
          use: (A a) => use(a).call,
          release: (A a) => release(a).call,
        )(call),
      );
}

extension FlatMapIOReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, B> flatMapIO<B>(
    I.IO<B> Function(A) f,
  ) =>
      RI.ReaderIOObj(
        RI.flatMapIO(f)(call),
      );
}

extension FlatMapReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, B> flatMap<B>(
    RI.ReaderIOObj<ENV, B> Function(A) f,
  ) =>
      RI.ReaderIOObj(
        RI.flatMap(
          (A a) => f(a).call,
        )(call),
      );
}

extension MapReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  RI.ReaderIOObj<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RI.ReaderIOObj(RI.map(f)(call));
}

extension SequenceArrayReaderIOObjExtension<ENV, A>
    on Iterable<RI.ReaderIO<ENV, A>> {
  RI.ReaderIOObj<ENV, Iterable<A>> sequenceArray() =>
      RI.ReaderIOObj(RI.sequenceArray(this));
}

extension ToReaderReaderIOObjExtension<ENV, A> on RI.ReaderIOObj<ENV, A> {
  R.ReaderObj<ENV, I.IO<A>> toReader() => R.ReaderObj(call);
}
