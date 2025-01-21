import 'dart:ffi';

import 'package:dart_glfw/dart_glfw.dart';
import 'package:dart_opengl/dart_opengl.dart';
import 'package:ffi/ffi.dart';
import 'package:logging/logging.dart';

final gl = loadOpenGL();
final glfw = loadGLFW('');

late final Logger? baseLogger;
Logger? getLogger(String system) {
  if (baseLogger == null) return null;
  return Logger("${baseLogger!.name}.$system");
}

void initDiamondGL({Logger? logger}) {
  baseLogger = logger;
}

extension CString on String {
  T withAsNative<T>(T Function(Pointer<Utf8>) action) {
    final pointer = toNativeUtf8();
    final result = action(pointer);
    malloc.free(pointer);

    return result;
  }
}
