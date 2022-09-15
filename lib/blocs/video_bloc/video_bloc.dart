import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_test/services/api_services.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoInitial()) {
    on<VideoEvent>(_postLogInData);
  }

  ///login bloc function
  void _postLogInData(VideoEvent event, Emitter<VideoState> emit) async {
    emit(VideoLaodWaiting());
    try {
      var res = await ApiService().videoList();

      emit(GetVideoListSuccess(videoData: res.data));
    } catch (ex) {
      if (ex != 'cancel') {
        emit(VideoLaodError(errorMessage: ex.toString()));
      }
    }
  }
}
