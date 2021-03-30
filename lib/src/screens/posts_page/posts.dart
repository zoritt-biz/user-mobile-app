

import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/posts_page/StoriesBloc.dart';
import 'package:zoritt_mobile_app_user/src/screens/posts_page/pages.dart' as pages;

class Post extends StatefulWidget{
  final List<pages.Story> posts;

  Post({@required this.posts});

  @override
  PostState createState()=>PostState();


}
class PostState extends State<Post>{
  PageController _pageController;
  double currentIndex=0.0;
  @override
  void initState() {
    _pageController=PageController();
    _pageController.addListener(() {
      setState(() {
        currentIndex = _pageController.page;

      });
    });

    super.initState();
  }
  @override
  void dispose() {
    _pageController.removeListener((){

    });
    _pageController.dispose();
    super.dispose();
  }
  void goToNext(){
    if(currentIndex.toInt()<widget.posts.length-1){
      _pageController.nextPage( duration: const Duration(milliseconds: 700),curve: Curves.easeInOut);
    }else{
      Navigator.pop(context);
      print("popped");
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<StoryBloc,StoryState>(listener: (context,state){

      if(state is StoryFinished){
        goToNext();
        context.read<StoryBloc>().emitUnknown();
        print("jumpped");
        print(currentIndex);
      }
    },
        child:PageView.builder(
        itemBuilder:(context,index){
          double value;
          if (_pageController.position.haveDimensions == false) {
            value = index.toDouble();
          } else {
            value = _pageController.page;
          }
          return _SwipeWidget(
            index: index,
            pageNotifier: value,
            child: widget.posts[index],
          );
        },
      controller: _pageController,
      itemCount: widget.posts.length,
        ));
  }

}
num degToRad(num deg) => deg * (pi / 180.0);

class _SwipeWidget extends StatelessWidget {
  final int index;

  final double pageNotifier;

  final Widget child;


  const _SwipeWidget({
    Key key,
    @required this.index,
    @required this.pageNotifier,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLeaving = (index - pageNotifier) <= 0;
    final t = (index - pageNotifier);
    final rotationY = lerpDouble(0, 90, t);
    final opacity = lerpDouble(0, 1, t.abs()).clamp(0.0, 1.0);
    final transform = Matrix4.identity();
    transform.setEntry(3, 2, 0.001);
    transform.rotateY(-degToRad(rotationY));
    return Transform(
      alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
      transform: transform,
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: Opacity(
              opacity: opacity,
              child: SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}