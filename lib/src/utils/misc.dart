import 'package:amap_base/src/utils/log.dart';

double devicePixelRatio = 1;

bool isEmpty(Object object) {
  if (object == null) {
    return true;
  }

  if (object is String) {
    return object.isEmpty;
  }

  if (object is Iterable) {
    return object.isEmpty;
  }

  if (object is Map) {
    return object.isEmpty;
  }

  return false;
}

bool isNotEmpty(Object object) {
  return !isEmpty(object);
}

bool isAllEmpty(List<Object> list) {
  if (isEmpty(list)) {
    return true;
  } else {
    return list.every(isEmpty);
  }
}

bool isAllNotEmpty(List<Object> list) {
  if (isEmpty(list)) {
    return false;
  }
  return !list.any(isEmpty);
}

String toResolutionAware(String path) {
  L.p('转换前路径: $path');
  if (isEmpty(path)) {
    return null;
  }

  List<String> pathFragment = path.split('/');
  pathFragment.insert(pathFragment.length - 1, '${devicePixelRatio}x');
  L.p('转换后路径: ${pathFragment.join()}');
  return pathFragment.join();
}
