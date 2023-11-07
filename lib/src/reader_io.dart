import '../io.dart' as I;
import '../reader.dart' as R;

typedef ReaderIO<ENV, A> = R.Reader<ENV, I.IO<A>>;

ReaderIO<ENV, B> Function<ENV>(ReaderIO<ENV, A>) flatMapIO<A, B>(
        I.IO<B> Function(A) f) =>
    <R>(ra) => (r) => f(ra(r)());

ReaderIO<ENV, B> Function(ReaderIO<ENV, A>) flatMap<ENV, A, B>(
        ReaderIO<ENV, B> Function(A) f) =>
    (ra) => (r) => f(ra(r)())(r);

ReaderIO<ENV, B> Function<ENV>(ReaderIO<ENV, A>) map<A, B>(B Function(A) f) =>
    <ENV>(ra) => (r) => () => f(ra(r)());
