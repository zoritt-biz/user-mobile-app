import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final String imageLink;

  ProfilePage({this.name, this.email, this.imageLink});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: ListView(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(widget.imageLink ??
                      "https://images.unsplash.com/photo-1614823498916-a28a7d67182c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
                  fit: BoxFit.fill),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              widget.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700]),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              widget.email,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700]),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Colors.grey[400],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.favorite_border_outlined),
              ),
              Tab(
                icon: Icon(Icons.bookmark_border_outlined),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: TabBarView(
              controller: _tabController,
              children: [
                Center(child: Text('Favorited')),
                Center(child: Text('Bookmarked')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
