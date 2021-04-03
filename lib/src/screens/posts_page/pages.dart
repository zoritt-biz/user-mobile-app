import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import 'StoriesBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Story extends StatefulWidget {
  final Post post;

  const Story({@required this.post});

  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  AnimationController _animController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    // final String firstImage = widget.images.first;
    _loadStory(animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.post.photos.length) {
            _currentIndex += 1;
            _loadStory(image: widget.post.photos[_currentIndex]);
          } else {

            context.read<StoryBloc>().emitStoryFinished();

            // _currentIndex = 0;
            // _loadStory(image: widget.images[_currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String image = widget.post.photos[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details, image),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.post.photos.length,
              itemBuilder: (context, i) {
                    // return Image.asset(
                    //   widget.images[i],
                    //   fit: BoxFit.cover,
                    //   width: double.infinity,
                    //   height: double.infinity,
                    // );
                return CachedNetworkImage(
                  imageUrl:widget.post.photos[i],
                  placeholder: (context,url){
                    return Container(
                      color: Colors.black,
                      child:Center(child: CircularProgressIndicator()),
                    );
                  },

                  imageBuilder: (context,imageProvider){

                    Future.delayed(Duration(milliseconds: 500)).then((value){

                        _animController?.forward();

                    });


                    return Container(
                        decoration: BoxDecoration(
                        image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                       ),
                    ));
                  },


                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );


                }


            ),
            Positioned(
              top: 40.0,
              left: 10.0,
              right: 10.0,
              child:
                  Row(
                    children: widget.post.photos
                        .asMap()
                        .map((i, e) {
                      return MapEntry(
                        i,
                        AnimatedBar(
                          animController: _animController,
                          position: i,
                          currentIndex: _currentIndex,
                        ),
                      );
                    })
                        .values
                        .toList(),
                  ),

              ),
            Positioned(
              bottom: 20,
              left:15,
              right:15,
              child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 1.5,
                vertical: 10.0,
              ),
              child: UserInfo(post: widget.post,),
            ),)

          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, String story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory();
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.post.photos.length) {
          _currentIndex += 1;
          _loadStory(image: widget.post.photos[_currentIndex]);
        } else {

          context.read<StoryBloc>().emitStoryFinished();

          // _currentIndex = 0;
          // _loadStory(image: widget.images[_currentIndex]);
        }
      });
    }
  }

  void _loadStory({String image,bool animateToPage=true}) {
    _animController.stop();
    _animController.reset();
    _animController.duration = Duration(seconds: 3);
    // _animController.forward();

    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key key,
    @required this.animController,
    @required this.position,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                  animation: animController,
                  builder: (context, child) {
                    return _buildContainer(
                      constraints.maxWidth * animController.value,
                      Colors.white,
                    );
                  },
                )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  final Post post;

  const UserInfo({
    Key key,
    @required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
      Text(
        "You can attend our event",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20.0),
      Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],

          backgroundImage: AssetImage(
          "assets/images/image.jpg",
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

               Text(
                post.businessName??"",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            // ),
            // Expanded(
              Text(
                post.description??"",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,

                ),
              // ),
            ),
          ],
        ),
          flex: 2,
        ),


        IconButton(
          icon: const Icon(
            Icons.favorite,
            size: 30.0,
            color: Color(0xffDF9C20),
          ),
          onPressed: () =>{

          },
        ),
        IconButton(
          icon: const Icon(
            Icons.share,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: (){

          },
        ),
      ],
    )]);
  }
}
