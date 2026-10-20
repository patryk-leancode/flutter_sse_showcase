import 'package:equatable/equatable.dart';

class const WikimediaChangeItem({
  required final String user,
  required final String title,
  required final int timestamp,
  required final String comment,
}) extends Equatable {
  @override
  List<Object?> get props => [user, title, timestamp, comment];
}
