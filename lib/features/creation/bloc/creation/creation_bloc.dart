import 'package:bloc/bloc.dart';
import 'package:me/shared/values/values.dart';
import 'package:meta/meta.dart';

part 'creation_event.dart';

part 'creation_state.dart';

class CreationBloc extends Bloc<CreationEvent, CreationState> {
  CreationBloc() : super(CreationInitial()) {
    on<LoadCreationEvent>(_loadCreation);
  }

  void _loadCreation(LoadCreationEvent event, Emitter<CreationState> emit) {
    emit(CreationLoading());

    Future.delayed(Duration(seconds: 2));

    emit(CreationLoaded(
      highlightedCreations: event.highlightedCreations,
      relatedCreations: event.relatedCreations,
      anotherCreations: event.anotherCreations,
    ));
  }
}
