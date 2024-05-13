part of 'merkcrud_bloc.dart';

class MerkCrudState extends Equatable {
  final MerkCrudModel? record;
  final bool isLoading;
  final bool isLoaded;
  final bool isSaving;
  final bool isSaved;
  final bool hasFailure;

  const MerkCrudState(
      {this.record,
      this.isLoading = false,
      this.isLoaded = false,
      this.isSaving = false,
      this.isSaved = false,
      this.hasFailure = false});

  MerkCrudState copyWith({
    MerkCrudModel? record,
    bool? isLoading,
    bool? isLoaded,
    bool? isSaving,
    bool? isSaved,
    bool? hasFailure,    
  }) {
    return MerkCrudState(
        record: record ?? this.record,
        isLoading: isLoading ?? this.isLoading,
        isLoaded: isLoaded ?? this.isLoaded,
        isSaving: isSaving ?? this.isSaving,
        isSaved: isSaved ?? this.isSaved,
        hasFailure: hasFailure ?? this.hasFailure);
  }

  @override
  List<Object> get props =>
      [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
