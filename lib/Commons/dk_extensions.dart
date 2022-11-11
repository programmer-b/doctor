import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

extension SnapshotReady on AsyncSnapshot {
  bool get ready {
    return connectionState == ConnectionState.done;
  }
}

extension ValueIsNull on dynamic {
  bool get isNull => this == 0 || this == null || this == false;
}

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}
