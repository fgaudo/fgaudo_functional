import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../io.dart';
import 'reader_io.dart' as RIO;

typedef ReaderStream<ENV, A> = Stream<A> Function(ENV);

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) map<A, B>(
  B Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).map(f);

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) switchMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).switchMap(f);

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) switchMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => (r) => ra(r).switchMap((a) => f(a)(r));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) flatMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).flatMap(f);

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) flatMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => (r) => ra(r).flatMap((a) => f(a)(r));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) concatMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).asyncExpand(f);

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) concatMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => (r) => ra(r).asyncExpand((a) => f(a)(r));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) exhaustMapStream<A, B>(
  Stream<B> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).exhaustMap(f);

ReaderStream<ENV, B> Function(ReaderStream<ENV, A>) exhaustMap<ENV, A, B>(
  ReaderStream<ENV, B> Function(A) f,
) =>
    (ra) => (r) => ra(r).exhaustMap((a) => f(a)(r));

ReaderStream<ENV, B> Function<ENV>(ReaderStream<ENV, A>) transformStream<A, B>(
  StreamTransformer<A, B> f,
) =>
    <ENV>(ra) => (r) => ra(r).transform(f);

ReaderStream<ENV, A> Function<ENV, A>(ReaderStream<ENV, A>) doOnListen(
  IO<void> f,
) =>
    <A, ENV>(ra) => (r) => ra(r).doOnListen(f);

ReaderStream<ENV, A> Function<A>(ReaderStream<ENV, A>) doOnListenReader<ENV>(
  RIO.ReaderIO<ENV, void> f,
) =>
    <A>(ra) => (r) => ra(r).doOnListen(f(r));

ReaderStream<ENV, A> Function<ENV>(ReaderStream<ENV, A>) doOnData<A>(
  IO<void> Function(A) f,
) =>
    <ENV>(ra) => (r) => ra(r).doOnData((a) => f(a)());

ReaderStream<ENV, A> Function(ReaderStream<ENV, A>) doOnDataReader<ENV, A>(
  RIO.ReaderIO<ENV, void> Function(A) f,
) =>
    (ra) => (r) => ra(r).doOnData((a) => f(a)(r)());

ReaderStream<ENV, A> Function<ENV>(ReaderStream<ENV, A>) startWith<A>(
  A a,
) =>
    <ENV>(ra) => (r) => ra(r).startWith(a);
