// Masukkan di file provider kamu
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRefreshProvider = StateProvider<int>((ref) => 0);