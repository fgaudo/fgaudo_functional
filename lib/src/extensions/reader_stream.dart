import '../../io.dart' as I;
import '../../reader.dart' as R;
import '../../reader_io.dart' as RIO;
import '../../reader_stream.dart' as RS;

extension AskReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, ENV> ask() => RS.ask();
}

extension AsksReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, ENV2> asks<ENV2>(
    R.Reader<ENV, ENV2> f,
  ) =>
      RS.asks(f);
}

extension ConcatMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> concatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.concatMapStream(f)(this);
}

extension ConcatMapReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> concatMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      RS.concatMap(f)(this);
}

extension DoOnDataIOStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnDataIO(
    I.IO<void> Function(A) f,
  ) =>
      RS.doOnDataIO(f)(this);
}

extension DoOnDataReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnData(
    RIO.ReaderIO<ENV, void> Function(A) f,
  ) =>
      RS.doOnData(f)(this);
}

extension DoOnListenIOReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnListenIO(
    I.IO<void> f,
  ) =>
      RS.doOnListenIO(f)(this);
}

extension DoOnListenReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> doOnListen(
    RIO.ReaderIO<ENV, void> f,
  ) =>
      RS.doOnListen(f)(this);
}

extension ExhaustMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> exhaustMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.exhaustMapStream(f)(this);
}

extension ExhaustMapStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> exhaustMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      RS.exhaustMap(f)(this);
}

extension FlatMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> flatMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.flatMapStream(f)(this);
}

extension FlatMapStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> flatMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      RS.flatMap(f)(this);
}

extension IgnoreElementsStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, Never> ignoreElements() => RS.ignoreElements(this);
}

extension MapReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RS.map(f)(this);
}

extension StartWithReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> startWith(
    A a,
  ) =>
      RS.startWith(a)(this);
}

extension SwitchMapStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> switchMapStream<B>(
    Stream<B> Function(A) f,
  ) =>
      RS.switchMapStream(f)(this);
}

extension SwitchMapReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> switchMap<B>(
    RS.ReaderStream<ENV, B> Function(A) f,
  ) =>
      RS.switchMap(f)(this);
}

extension ToReaderReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  R.Reader<ENV, Stream<A>> toReader() => R.Reader(call);
}

extension TransformStreamReaderStreamExtension<ENV, A>
    on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, B> transformStream<B>(
    Stream<B> Function(Stream<A>) f,
  ) =>
      RS.transformStream(f)(this);
}

extension WhereTypeReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, T> whereType<T>() => RS.whereType<T>()(this);
}

extension WhereReaderStreamExtension<ENV, A> on RS.ReaderStream<ENV, A> {
  RS.ReaderStream<ENV, A> where(bool Function(A) predicate) =>
      RS.where(predicate)(this);
}
