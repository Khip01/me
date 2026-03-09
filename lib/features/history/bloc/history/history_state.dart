part of 'history_bloc.dart';

@immutable
sealed class HistoryState {
  final List<HistoryItemData> historyDataWork;
  final List<HistoryItemData> historyDataEdu;

  const HistoryState(
      {required this.historyDataWork, required this.historyDataEdu});
}

final class HistoryInitial extends HistoryState {
  HistoryInitial() : super(historyDataEdu: [], historyDataWork: []);
}

final class HistoryLoaded extends HistoryState {
  const HistoryLoaded({
    required super.historyDataWork,
    required super.historyDataEdu,
  });
}
