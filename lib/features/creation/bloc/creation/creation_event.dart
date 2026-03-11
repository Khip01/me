part of 'creation_bloc.dart';

@immutable
sealed class CreationEvent {}

/// Initial event to load creation data with staggered phases
class LoadCreationEvent extends CreationEvent {
  final List<ProjectItemData> highlightedCreations;
  final List<ProjectItemData> relatedCreations;
  final List<ProjectItemData> anotherCreations;

  LoadCreationEvent({
    required this.highlightedCreations,
    required this.relatedCreations,
    required this.anotherCreations,
  });
}

/// Event to pre-cache/pre-load heavy assets (images) in the background
class PreloadCreationImagesEvent extends CreationEvent {
  final List<ProjectItemData> highlightedCreations;

  PreloadCreationImagesEvent({
    required this.highlightedCreations,
  });
}
