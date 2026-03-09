part of 'creation_bloc.dart';

@immutable
sealed class CreationEvent {}

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

