import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/model/peliculas_model.dart';

class CardSwiper extends StatelessWidget {
  
  final List<Pelicula> items; 

  CardSwiper({ @required this.items });
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
          itemBuilder: (BuildContext context,int index){

            items[index].uniqueId = '${items[index].id}-tarjeta';

            return Hero(
              tag: items[index].uniqueId,
              child: ClipRRect(
                borderRadius:BorderRadius.circular(20),
                child: GestureDetector(
                  onTap:()=> Navigator.pushNamed(context, 'detalle', arguments: items[index]),
                  child: FadeInImage(
                    image: NetworkImage( items[index].getPosterImg() ),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover 
                    ),
                ),
              ),
            );
          },
          itemWidth: _screenSize.width *0.6,
          itemHeight: _screenSize.height *0.4,
          itemCount: items.length,
          layout: SwiperLayout.STACK,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );
  }
}