

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class StoryBloc extends Cubit<StoryState>{
  StoryBloc() : super(StoryUnknown());

  void emitStoryFinished(){
    print("emitted");
    emit(StoryFinished());
  }
  void emitUnknown(){
    print("unknown emitted");
    emit(StoryUnknown());
  }

}
abstract class StoryState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];

}
class StoryFinished extends StoryState{}
class StoryUnknown extends StoryState{}
