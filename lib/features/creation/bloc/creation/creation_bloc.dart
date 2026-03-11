import 'package:bloc/bloc.dart';
import 'package:me/shared/values/values.dart';
import 'package:meta/meta.dart';

part 'creation_event.dart';

part 'creation_state.dart';

class CreationBloc extends Bloc<CreationEvent, CreationState> {
  CreationBloc() : super(CreationInitial()) {
    on<LoadCreationEvent>(_loadCreation);
    on<PreloadCreationImagesEvent>(_preloadImages);
  }

  /// Phase 1: Load basic data and emit intermediate state quickly
  /// This shows the UI with text + blurhash placeholders without waiting for heavy assets
  Future<void> _loadCreation(
    LoadCreationEvent event,
    Emitter<CreationState> emit,
  ) async {
    emit(CreationLoading());

    // Simulate small delay for data preparation (minimal)
    await Future.delayed(const Duration(milliseconds: 100));

    // Emit intermediate state - UI is ready to show with basic data + blurhash
    emit(
      CreationDataLoaded(
        highlightedCreations: event.highlightedCreations,
        relatedCreations: event.relatedCreations,
        anotherCreations: event.anotherCreations,
      ),
    );

    // Trigger background pre-loading of heavy assets without blocking UI
    // This happens asynchronously after the first render
    add(PreloadCreationImagesEvent(
      highlightedCreations: event.highlightedCreations,
    ));
  }

  /// Phase 2: Pre-cache heavy assets in background
  /// This does not rebuild the entire page, but prepares resources
  /// You can extend this to actually precache image assets if needed
  Future<void> _preloadImages(
    PreloadCreationImagesEvent event,
    Emitter<CreationState> emit,
  ) async {
    // Simulate async work (image precaching, network fetches, etc)
    // This runs without blocking the UI thread
    await Future.delayed(const Duration(milliseconds: 500));

    // Optional: If you want to emit a final "ready" state after all assets are loaded
    // Uncomment below. Otherwise, CreationDataLoaded is enough for smooth rendering.
    //
    // emit(
    //   CreationReady(
    //     highlightedCreations: event.highlightedCreations,
    //     relatedCreations: [], // Use previously emitted data or maintain state
    //     anotherCreations: [],
    //   ),
    // );
  }
}
