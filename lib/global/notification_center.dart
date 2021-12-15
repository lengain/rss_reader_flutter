

import 'package:flutter/cupertino.dart';

typedef NotificationBlock = void Function(dynamic arg);

class NotificationItem {
  late NotificationBlock block;
  dynamic associatedObject;

  NotificationItem(this.associatedObject, this.block);
}

class NotificationCenter {
  NotificationCenter._internal();
  static final NotificationCenter _singleton = NotificationCenter._internal();
  factory NotificationCenter() => _singleton;
  static NotificationCenter defaultCenter() => _singleton;

  final _notifications = <String,List<NotificationItem>>{};

  void addNotification(String name, dynamic associatedObject, NotificationBlock block) {
    _notifications[name] ??= [];
    _notifications[name]?.add(NotificationItem(associatedObject, block));
  }

  void postNotification(String name, {dynamic arg}) {
      _notifications[name]?.forEach((item) {
        item.block(arg);
      });
  }

  void removeNotification({String? name, dynamic associatedObject}) {
    if (associatedObject != null) {
      if (name == null) {
        _notifications.forEach((key, value) {
          value.removeWhere((element) => element.associatedObject == associatedObject);
        });
      }else {
        _notifications[name]?.removeWhere((element) => element.associatedObject == associatedObject);
      }
    } else {
      if (name != null) {
        _notifications.remove(name);
      }
    }
  }

}