part of 'creation_bloc.dart';

@immutable
sealed class CreationState {
  final List<ProjectItemData> highlightedCreations;
  final List<ProjectItemData> relatedCreations;
  final List<ProjectItemData> anotherCreations;

  const CreationState({
    required this.highlightedCreations,
    required this.relatedCreations,
    required this.anotherCreations,
  });
}

/// Initial state before any data is loaded
final class CreationInitial extends CreationState {
  CreationInitial()
      : super(
          highlightedCreations: [],
          relatedCreations: [],
          anotherCreations: [],
        );
}

/// Loading state - show shimmer/skeleton UI
final class CreationLoading extends CreationState {
  CreationLoading()
      : super(
          highlightedCreations: [],
          relatedCreations: [],
          anotherCreations: [],
        );
}

/// Intermediate state - basic data and blurhash loaded, ready for UI
/// but heavy assets (full resolution images) are still being pre-cached in background
final class CreationDataLoaded extends CreationState {
  const CreationDataLoaded({
    required super.highlightedCreations,
    required super.relatedCreations,
    required super.anotherCreations,
  });
}

/// Final state - all data and heavy assets are ready
final class CreationReady extends CreationState {
  const CreationReady({
    required super.highlightedCreations,
    required super.relatedCreations,
    required super.anotherCreations,
  });
}
