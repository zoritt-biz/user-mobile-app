import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_detail/business_detail_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/business_detail/business_detail_state.dart';
import 'package:zoritt_mobile_app_user/src/models/business.dart';
import 'package:zoritt_mobile_app_user/src/models/event.dart';
import 'package:zoritt_mobile_app_user/src/models/post.dart';

class BusinessDetail extends StatefulWidget {
  static const String pathName = "/business_detail";

  @override
  _BusinessDetailState createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  ScrollController _scrollController;

  bool lastStatus = true;
  List<String> images = [
    "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
    "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
  ];

  _scrollListener() {
    if (isShrink != lastStatus) {
      setState(() {
        lastStatus = isShrink;
      });
    }
  }

  bool get isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (220 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessDetailBloc, BusinessDetailState>(
      builder: (bizCtx, bizState) {
        if (bizState is BusinessDetailLoadSuccess) {
          return body(bizState.business);
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget body(Business business) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.grey,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: isShrink ? Colors.black : Colors.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border_outlined,
                      color: isShrink ? Colors.black : Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.share_outlined,
                      color: isShrink ? Colors.black : Colors.white,
                    ),
                  ],
                ),
              ),
            ],
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(business.pictures[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.1),
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Padding(
                padding: isShrink
                    ? EdgeInsets.only(bottom: 0)
                    : EdgeInsets.only(bottom: 10),
                child: Text(
                  business.businessName,
                  style: TextStyle(
                    color: isShrink ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          BusinessAddress(
              name: business.slogan != null ? business.slogan : "",
              time: '9:00 AM - 6:00 PM',
              localTime: true,
              phoneNumber: business.phoneNumber[0],
              website: business.website,
              location: business.location),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          BusinessLocation(
            imageLink:
            "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
            address1: business.location,
            address2: 'Ethiopia',
            address3: 'አዲስ አበባ',
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          BusinessInfo(
            phoneNumber: business.phoneNumber[0],
            webAddress: business.website,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          BusinessEvent(events: business.events),
          BusinessPost(posts: business.posts),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          BusinessMedia(),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          RelatedBusiness(
            imageLink: images,
          )
        ],
      ),
    );
  }
}

class BusinessAddress extends StatelessWidget {
  final String name;
  final String time;
  final bool localTime;
  final String phoneNumber;
  final String website;
  final String location;

  BusinessAddress(
      {this.name,
        this.time,
        this.localTime,
        this.phoneNumber,
        this.website,
        this.location});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Open',
                    style: TextStyle(color: Colors.orange, fontSize: 15),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    localTime == true ? 'ET' : '',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: IconButton(
                      icon: Icon(Icons.phone_outlined),
                      onPressed: () async {
                        await canLaunch("tel:$phoneNumber")
                            ? await launch("tel:$phoneNumber")
                            : throw 'Could not launch $phoneNumber';
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: IconButton(
                      icon: Icon(Icons.language_outlined),
                      onPressed: () async {
                        await canLaunch(website)
                            ? await launch(website)
                            : throw 'Could not launch $website';
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: Icon(Icons.push_pin_outlined),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessLocation extends StatelessWidget {
  final String address1;
  final String address2;
  final String address3;
  final String imageLink;

  BusinessLocation(
      {this.address1, this.address2, this.address3, this.imageLink});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageLink,
              height: 150,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get Directions',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.location_pin)
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
              child: Text(
                address1,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                address2,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 25),
              child: Text(
                address3,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessInfo extends StatelessWidget {
  final String phoneNumber;
  final String webAddress;

  BusinessInfo({this.phoneNumber, this.webAddress});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Business Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(Icons.phone_outlined)
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/menu_display");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Explore The Menu',
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.search_outlined)
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    webAddress,
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(Icons.language_outlined)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Expanded(
                        flex: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? 1
                            : 4,
                        child: Container(
                          child: null,
                        )),
                    Expanded(
                        flex: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? 2
                            : 3,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black,
                              side: BorderSide(color: Colors.amber),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/more_business_info');
                            },
                            child: Text('More Info'))),
                    Expanded(
                        flex: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                            ? 1
                            : 4,
                        child: Container(
                          child: null,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessEvent extends StatelessWidget {
  final List<Events> events;

  const BusinessEvent({Key key, this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[300]),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Icon(FontAwesomeIcons.tasks),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sorry, There is no events or discount in the restaurant',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessPost extends StatelessWidget {
  final List<Post> posts;

  const BusinessPost({Key key, this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[300]),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Icon(FontAwesomeIcons.tasks),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sorry, There is no events or discount in the restaurant',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessMedia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Photos and Videos',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Icon(
                    FontAwesomeIcons.arrowRight,
                    color: Colors.orange,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          child: Image.network(
                              "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            Expanded(
                              flex: 9,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          child: Image.network(
                              "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
                        ),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            Expanded(
                              flex: 9,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Food & Drink',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RelatedBusiness extends StatelessWidget {
  final List<String> imageLink;

  RelatedBusiness({this.imageLink});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Related Businesses',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Icon(
                    FontAwesomeIcons.arrowRight,
                    color: Colors.orange,
                  )
                ],
              ),
            ),
            Column(
              children: [
                SingleBusinessItem(
                  imageLink: imageLink[0],
                  name: 'Wow Burger 1',
                  address: 'Arat kilo, Addis Ababa 1',
                  phoneNumber: '+2519123654789',
                ),
                SingleBusinessItem(
                  imageLink: imageLink[1],
                  name: 'Wow Burger 1',
                  address: 'Arat kilo, Addis Ababa 1',
                  phoneNumber: '+2519123654789',
                ),
                SingleBusinessItem(
                  imageLink: imageLink[2],
                  name: 'Wow Burger 1',
                  address: 'Arat kilo, Addis Ababa 1',
                  phoneNumber: '+2519123654789',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SingleBusinessItem extends StatelessWidget {
  final String imageLink;
  final String name;
  final String address;
  final String phoneNumber;
  final bool isFirst;

  SingleBusinessItem({
    this.imageLink,
    this.isFirst,
    this.name,
    this.phoneNumber,
    this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(left: 18, right: 18, bottom: 18),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Image.network(
              imageLink,
              fit: BoxFit.fill,
              height: 100,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text('\$\$')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    address,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    phoneNumber,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
