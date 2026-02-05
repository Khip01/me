import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SidebarProvider with ChangeNotifier {
  SidebarState _state = SidebarState.close;

  SidebarState get state => _state;

  bool get isOpened => state == SidebarState.open;

  set state(SidebarState v) {
    if (_state != v) {
      _state = v;
      notifyListeners();
    }
  }

  void toggle() {
    state =
        (_state == SidebarState.open) ? SidebarState.close : SidebarState.open;
  }
}

class SidebarThumbProvider with ChangeNotifier {
  SidebarThumbState _state = SidebarThumbState.hide;

  SidebarThumbState get state => _state;

  bool get isVisible => _state == SidebarThumbState.show;

  set state(SidebarThumbState v) {
    if (_state != v) {
      _state = v;
      notifyListeners();
    }
  }

  void updateState(SidebarThumbState newState) {
    state = newState;
  }

  void toggle() {
    state = (_state == SidebarThumbState.show)
        ? SidebarThumbState.hide
        : SidebarThumbState.show;
  }
}

enum SidebarState {
  open,
  close,
}

enum SidebarThumbState {
  show,
  hide,
}

final sidebarProvider = ChangeNotifierProvider((ref) => SidebarProvider());
final sidebarThumbProvider =
    ChangeNotifierProvider((ref) => SidebarThumbProvider());
