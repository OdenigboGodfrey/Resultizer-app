import 'dart:async';

Future<dynamic> customPromise(Function action) async {
    Completer<dynamic> completer = Completer<dynamic>();

    // Simulate an asynchronous operation
    action().then((value) {
      completer.complete(true);
    }).catchError((err) {
      completer.complete(false);
    });

    return completer.future;
  }