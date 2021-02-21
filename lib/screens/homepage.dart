import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/dishes.dart';
import 'package:restaurant_app/screens/favourites.dart';
import 'package:restaurant_app/screens/profile.dart';
import 'package:restaurant_app/widgets/grid_product.dart';
import 'package:restaurant_app/widgets/home_category.dart';
import 'package:restaurant_app/widgets/slider_item.dart';
import 'package:restaurant_app/util/foods.dart';
import 'package:restaurant_app/util/categories.dart';
import 'package:restaurant_app/util/popular_food.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'cart.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home>{

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar:new AppBar(
          title: GestureDetector(

            child:
            new Text("RESTAURANT APP"),
          ),
          centerTitle: true,
          actions: <Widget>[
      new IconButton(
      icon: new Icon(
          Icons.person,
          color: Colors.blueAccent),
        onPressed: () {  Navigator.of(context).push(
            MaterialPageRoute(

                  builder: (BuildContext context) {

               return Profile();

        }
        ),
    );
        },
    )
    ]
    ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Dishes",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                FlatButton(
                  child: Text(
                    "View More",
                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(

                        builder: (BuildContext context) {

                          return DishesScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here

            CarouselSlider(
              height: MediaQuery.of(context).size.height/2.4,
              items: map<Widget>(
                foods,
                    (index, i){
                  Map category = foods[index];
                  return SliderItem(
                    img: category['img'],
                    isFav: false,
                    name: category['name'],
                    rating: 5.0,
                    raters: 23,
                  );
                },
              ).toList(),
              autoPlay: true,
//                enlargeCenterPage: true,
              viewportFraction: 1.0,
//              aspectRatio: 2.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),
            SizedBox(height: 20.0),

            Text(
              "Food Categories",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null?0:categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];
                  return HomeCategory(
                    icon: cat['icon'],
                    title: cat['name'],
                    items: cat['items'].toString(),
                    isHome: true,
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Popular Items",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                FlatButton(
                  child: Text(
                    "View More",
                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: (){},
                ),
              ],
            ),
            SizedBox(height: 10.0),

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.25),
              ),
              itemCount: popularfoods == null ? 0 :popularfoods.length,
              itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                Map popularfood = popularfoods[index];
//                print(foods);
//                print(foods.length);
                return GridProduct(
                  img: popularfood['img'],
                  isFav: false,
                  name: popularfood['name'],
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
      floatingActionButton: new Stack(
        children: <Widget>[
          new FloatingActionButton(
                 onPressed: (){
                 Navigator.of(context).push(
            MaterialPageRoute(

              builder: (BuildContext context) {

               return CartScreen();
               },
            ),
           );

            },
            child: new Icon(Icons.shopping_cart),

          ),
          ]
            ),


    );

  }

  @override
  bool get wantKeepAlive => true;
}
