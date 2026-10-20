import 'package:equatable/equatable.dart';

class const NumberData({required final int value}) extends Equatable {
  factory fromString(String data) {
    return NumberData(value: int.parse(data));
  }

  @override
  String toString() => 'NumberData(value: $value)';

  @override
  List<Object?> get props => [value];
}
