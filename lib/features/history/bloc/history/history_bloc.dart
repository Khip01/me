import 'package:bloc/bloc.dart';
import 'package:me/shared/values/values.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<LoadHistoryEvent>(_loadHistory);
  }

  void _loadHistory(LoadHistoryEvent event, Emitter<HistoryState> emit) {
    emit(HistoryLoaded(
      historyDataWork: event.historyDataWork,
      historyDataEdu: event.historyDataEdu,
    ));
  }
}
