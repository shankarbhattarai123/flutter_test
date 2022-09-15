part of 'video_bloc.dart';

@immutable
abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoLaodError extends VideoState {
  final String errorMessage;

  VideoLaodError({
    required this.errorMessage,
  });
}

class VideoLaodWaiting extends VideoState {}

class GetVideoListSuccess extends VideoState {
  List videoData;

  GetVideoListSuccess({
    required this.videoData,
  });
}
