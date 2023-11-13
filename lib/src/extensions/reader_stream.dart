import '../../io.dart' as I;
import '../../reader.dart' as R;
import '../../reader_io.dart' as RIO;
import '../../reader_stream.dart' as RS;

extension AskReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, ENV> ask() => RS.ReaderStreamObj(RS.ask<ENV>());
}

extension AsksReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, ENV2> asks<ENV2>(
    R.Reader<ENV, ENV2> f,
  ) =>
      RS.ReaderStreamObj(
        RS.asks(f),
      );
}

extension ConcatMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> concatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.concatMapStream(f)(call),
      );
}

extension ConcatMapReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> concatMap<B>(
    RS.ReaderStreamObj<ENV, B> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.concatMap((A a) => f(a).call)(call),
      );
}

extension DoOnDataIOStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, A> doOnDataIO(
    I.IO<void> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.doOnDataIO(f)(call),
      );
}

extension DoOnDataReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, A> doOnData(
    RIO.ReaderIO<ENV, void> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.doOnData(f)(call),
      );
}

extension DoOnListenIOReaderStreamExtension<ENV, A>
    on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, A> doOnListenIO(
    I.IO<void> f,
  ) =>
      RS.ReaderStreamObj(
        RS.doOnListenIO(f)(call),
      );
}

extension DoOnListenReaderStreamExtension<ENV, A>
    on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, A> doOnListen(
    RIO.ReaderIO<ENV, void> f,
  ) =>
      RS.ReaderStreamObj(
        RS.doOnListen(f)(call),
      );
}

extension ExhaustMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> exhaustMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.exhaustMapStream(f)(call),
      );
}

extension ExhaustMapStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> exhaustMap<B>(
    RS.ReaderStreamObj<ENV, B> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.exhaustMap((A a) => f(a).call)(call),
      );
}

extension FlatMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> flatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.flatMapStream(f)(call),
      );
}

extension FlatMapStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> flatMap<B>(
    RS.ReaderStreamObj<ENV, B> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.flatMap((A a) => f(a).call)(call),
      );
}

extension IgnoreElementsStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, Never> ignoreElements() =>
      RS.ReaderStreamObj(RS.ignoreElements(call));
}

extension MapReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.map(f)(call),
      );
}

extension StartWithReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, A> startWith(
    A a,
  ) =>
      RS.ReaderStreamObj(
        RS.startWith(a)(call),
      );
}

extension SwitchMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> switchMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.switchMapStream(f)(call),
      );
}

extension SwitchMapReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> switchMap<B>(
    RS.ReaderStreamObj<ENV, B> Function(A) f,
  ) =>
      RS.ReaderStreamObj(
        RS.switchMap((A a) => f(a).call)(call),
      );
}

extension ToReaderReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  R.ReaderObj<ENV, Stream<A>> toReader() => R.ReaderObj(call);
}

extension TransformStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, B> transformStream<B>(
    Stream<B> Function(Stream<A>) f,
  ) =>
      RS.ReaderStreamObj(
        RS.transformStream(f)(call),
      );
}

extension WhereTypeReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, T> whereType<T>() =>
      RS.ReaderStreamObj(RS.whereType<T>()(call));
}

extension WhereReaderStreamExtension<ENV, A> on RS.ReaderStreamObj<ENV, A> {
  RS.ReaderStreamObj<ENV, A> where(bool Function(A) predicate) =>
      RS.ReaderStreamObj(
        RS.where(predicate)(call),
      );
}
