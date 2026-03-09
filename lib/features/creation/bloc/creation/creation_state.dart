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

final class CreationInitial extends CreationState {
  CreationInitial()
      : super(
          highlightedCreations: [],
          relatedCreations: [],
          anotherCreations: [],
        );
}

final class CreationLoading extends CreationState {
  CreationLoading()
      : super(
          highlightedCreations: [],
          relatedCreations: [],
          anotherCreations: [],
        );
}

final class CreationLoaded extends CreationState {
  const CreationLoaded({
    required super.highlightedCreations,
    required super.relatedCreations,
    required super.anotherCreations,
  });
}
