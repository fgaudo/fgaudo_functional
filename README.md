This library introduces numerous pure functional types, much like [fp-ts](https://gcanti.github.io/fp-ts/)

## Features

Here are some examples of types which you may find

- Either
- IO
- Task
- Reader
- ReaderStream
- ...

Keep in mind that I will be adding more types as I continue development.
If you need one in particular, just open an issue.

## Usage

Here's an example:

```dart
import 'package:functionally/extensions/reader_stream.dart';
import 'package:functionally/reader_stream.dart' as RS;

void main() {
  final RS.ReaderStream<String, String> readerStream =
      RS.ask<String>().map((hello) => '$hello World');

  readerStream('Hello').listen(print);
}
```
This sample will probably not help you much if you don't have experience with pure functional paradigms.
If you have experience with typescript and want to learn more, i suggest searching online guides about `fp-ts`.
Otherwise consider learning [Haskell](https://www.haskell.org/) :P.

You may also find more examples in [Fridgy](https://github.com/fgaudo/fridgy), an app written with this library.