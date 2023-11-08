import '../../../reader_io.dart' as RI;

extension BracketReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, B> bracket<B>({
    required RI.ReaderIO<ENV, void> Function(A) release,
    required RI.ReaderIO<ENV, B> Function(A) use,
  }) =>
      RI.bracket(
        use: use,
        release: release,
      )(this);
}
