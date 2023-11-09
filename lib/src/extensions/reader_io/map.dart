import '../../../io.dart' as I;
import '../../../reader.dart' as R;
import '../../../reader_io.dart' as RI;

extension MapReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> map<B>(
    B Function(A) f,
  ) =>
      RI.map(f)(this);

  RI.ReaderIO<ENV, B> reader_map<B>(
    I.IO<B> Function(I.IO<A>) f,
  ) =>
      R.map(f)(this);
}
