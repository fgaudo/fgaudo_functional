import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../either.dart';
import '../extensions/either/map.dart';
import '../io.dart';
import '../reader.dart';
import '../task.dart';
import 'extensions/either/flat_map.dart';
import 'functionally.dart';

typedef Writer<W, A> = (A, List<Monoid<W>>);

typedef IOWriter<W, A> = IO<Writer<W, A>>;
typedef ReaderIOWriterEither<R, W, E, A>
    = Reader<R, IO<Writer<W, Either<E, A>>>>;

typedef TaskWriter<W, A> = Task<Writer<W, A>>;
typedef ReaderTaskWriterEither<R, W, E, A>
    = Reader<R, Task<Writer<W, Either<E, A>>>>;

typedef StreamWriter<W, A> = Stream<Either<W, A>>;
typedef ReaderStreamWriterEither<R, W, E, A>
    = Reader<R, Stream<Either<W, Either<E, A>>>>;

Writer<W, B> Function(Writer<W, A>) flatMap<W, A, B>(
  Writer<W, B> Function(A) f,
) =>
    (w) {
      final wb = f(w.$1);
      return (
        wb.$1,
        wb.$2.append(w.$2.value),
      );
    };

StreamEitherWriter<W, E, A> Function<E, A>(StreamEitherWriter<W, E, A>) log<W>(
  W w,
) =>
    <E, A>(sew) => sew.flatMap(
          (either) => switch (either) {
            Right() => Stream.fromIterable([
                either.flatMap(
                  (_) => Left(w),
                ),
                either,
              ]),
            _ => Stream.value(either)
          },
        );

Writer<List<String>, void> log(
  String text,
) =>
    tell(
      MonoidList(
        [text],
      ),
    );

Writer<Stream<String>, void> logS(
  String text,
) =>
    tell(
      MonoidStream(
        FromCallableStream(() => text),
      ),
    );

TaskWriter<W, B> Function(TaskWriter<W, A>) flatMapTask<A, B, W>(
  TaskWriter<W, B> Function(A) f,
) =>
    (tw) {
      final cont = StreamController<W>();
      return (
        () async {
          final lol = f(await tw.$1());

          await cont.addStream(lol.$2);
          await cont.close();
          return lol.$1();
        },
        tw.$2.concatWith([cont.stream])
      );
    };

StreamWriter<String, B> Function(StreamWriter<String, A>) flatMapStream<A, B>(
  StreamWriter<String, B> Function(A) f,
) =>
    (io) => io.flatMap(
          (either) => switch (either) {
            Right() => f(either.value),
            Left() => Stream.value(Left(either.value)),
          },
        );

IOWriter<Stream<String>, B> Function(IOWriter<Stream<String>, A>)
    flatMapIO<A, B>(
  IOWriter<Stream<String>, B> Function(A) f,
) =>
        (io) {
          final cont = StreamController<String>();
          return (
            () {
              final asd = io.$1();

              final lol = f(asd);
              cont.addStream(lol.$2.value).then(
                    (value) => cont.close(),
                  );

              return lol.$1();
            },
            io.$2.append(cont.stream)
          );
        };

Future<void> main2() async {
  final asd = flatMapTask(
    (a) => (
      () => Future.delayed(
            Duration(seconds: 3),
          ),
      MonoidStream(Stream.value('6')),
    ),
  )(
    (
      () => Future.delayed(
            Duration(seconds: 2),
          ),
      MonoidStream(Stream.value('1')),
    ),
  );

  asd.$2.value.listen(print);

  await asd.$1();
}

Future<void> main3() async {
  final asd = flatMapStream(
    (a) => (
      Stream.fromFuture(
        Future.delayed(Duration(seconds: 3)),
      ),
      MonoidStream(Stream.value('3')),
    ),
  )(
    (
      Stream.fromFuture(
        Future.delayed(Duration(seconds: 1)),
      ),
      MonoidStream(Stream.value('1')),
    ),
  );

  asd.$2.value.listen(print);

  asd.$1.listen((event) {});
}

Future<void> main() async {
  final asd = flatMapIO(
    (a) => (
      () {
        print('ciao');
      },
      MonoidStream(Stream.value('3')),
    ),
  )(
    (
      () {
        print('ciaociao');
        return null;
      },
      MonoidStream(Stream.value('1')),
    ),
  );

  asd.$2.value.listen(print);

  asd.$1();
}
