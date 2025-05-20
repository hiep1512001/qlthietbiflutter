import 'package:flutter_riverpod/flutter_riverpod.dart';

final obscureTextPassWord = StateProvider<bool>((ref) => true);
final selectedIndexTab = StateProvider<int>((ref) => 0);
