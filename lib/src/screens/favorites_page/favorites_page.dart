import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites_bloc/favorites_bloc.dart';
import 'package:zoritt_mobile_app_user/src/bloc/favorites_bloc/favorites_state.dart';
import 'package:zoritt_mobile_app_user/src/screens/search_page/search_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (favoriteCtx, favoritesState) {
          if (favoritesState is FavoritesLoadSuccessful) {
            if (favoritesState.business.isNotEmpty) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: favoritesState.business.length,
                itemBuilder: (context, index) => SearchResult(
                  business: favoritesState.business[0],
                ),
              );
            } else {
              return Center(
                child: Text("You have note liked any business"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// class FavoriteItem extends StatefulWidget {
//   final String title;
//   final String address;
//   final String phoneNumber;
//   final double price;
//   final String name;
//   final bool openNow;
//   final bool outdoor;
//   final bool delivery;
//   final List<String> images;
//   final bool lastElement;
//
//   FavoriteItem(
//       {this.title,
//       this.address,
//       this.phoneNumber,
//       this.price,
//       this.name,
//       this.openNow,
//       this.outdoor,
//       this.delivery,
//       this.images,
//       this.lastElement});
//
//   @override
//   _FavoriteItemState createState() => _FavoriteItemState();
// }
//
// class _FavoriteItemState extends State<FavoriteItem> {
//   List<Widget> horizontalImages;
//
//   @override
//   Widget build(BuildContext context) {
//     horizontalImages = [];
//     for (int i = 0; i < widget.images.length; i++) {
//       if (i != widget.images.length - 1) {
//         horizontalImages.add(
//           ClipRRect(
//             borderRadius: BorderRadius.all(
//               Radius.circular(5),
//             ),
//             child: Image.network(
//               widget.images[i],
//               fit: BoxFit.fill,
//               width: 100,
//               // height: 100,
//             ),
//           ),
//         );
//         horizontalImages.add(
//           SizedBox(
//             width: 8,
//           ),
//         );
//       } else {
//         horizontalImages.add(
//           ClipRRect(
//             borderRadius: BorderRadius.all(
//               Radius.circular(5),
//             ),
//             child: Image.network(
//               widget.images[i],
//               // fit: BoxFit.fill,
//               width: 100,
//               // height: 100,
//             ),
//           ),
//         );
//       }
//     }
//
//     print(horizontalImages.length);
//     return Padding(
//       padding: EdgeInsets.only(
//           left: 5, right: 5, bottom: widget.lastElement == true ? 0 : 10),
//       child: Card(
//         elevation: 7,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.title,
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                     ),
//                     Icon(
//                       Icons.favorite,
//                       color: Colors.orange,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   widget.address,
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   widget.phoneNumber,
//                   style: TextStyle(fontSize: 15),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       '\$${widget.price.toString()}',
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Text(
//                       widget.name,
//                       style: TextStyle(fontSize: 15),
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         if (widget.openNow != null)
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.check,
//                                 color: Colors.green,
//                               ),
//                               // SizedBox(
//                               //   width: 5,
//                               // ),
//                               Text(
//                                 'Open Now',
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.grey[600]),
//                               )
//                             ],
//                           ),
//                         if (widget.outdoor != null)
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(
//                                 Icons.check,
//                                 color: Colors.green,
//                               ),
//                               // SizedBox(
//                               //   width: 5,
//                               // ),
//                               Text(
//                                 'Outdoor Seating',
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.grey[600]),
//                               )
//                             ],
//                           ),
//                         if (widget.delivery != null)
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Icon(
//                                 Icons.check,
//                                 color: Colors.green,
//                               ),
//                               // SizedBox(
//                               //   width: 5,
//                               // ),
//                               Text(
//                                 'Delivery',
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.grey[600]),
//                               )
//                             ],
//                           )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: horizontalImages,
//                     ),
//                   ),
//                 )
//               ]),
//         ),
//       ),
//     );
//   }
// }
