part of 'history_bloc.dart';

@immutable
sealed class HistoryEvent {}

class LoadHistoryEvent extends HistoryEvent {
  final List<HistoryItemData> historyDataWork;
  final List<HistoryItemData> historyDataEdu;

  LoadHistoryEvent({
    required this.historyDataWork,
    required this.historyDataEdu,
  });
}
