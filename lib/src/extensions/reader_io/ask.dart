import '../../../reader_io.dart' as RI;
import 'flat_map.dart';

extension AskReaderIOExtension<ENV, A> on RI.ReaderIO<ENV, A> {
  RI.ReaderIO<ENV, ENV> ask() => flatMap((_) => ask());
}
