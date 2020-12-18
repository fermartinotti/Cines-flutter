import 'package:flutter/material.dart';
import 'package:peliculas/src/provider/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swipper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  PeliculasProvider peliculasProvider = new PeliculasProvider();


  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text ("Peliculas en cines"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                context: context, 
                delegate: DataSearch(),
              );
            },
          )
        ],
      ),
      body: Container( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context)
          ],
        )
      )
    
    );
  }

  _swiperTarjetas() {

    return FutureBuilder(

      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if (snapshot.hasData){
          return CardSwiper(items: snapshot.data);
        } else {
          return Container(
            height: 300,
            child: Center(child: CircularProgressIndicator())
          );
        }
      },

    );

  }

  _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left:20),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)),
          //SizedBox(height: 5),

          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              if (snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,);
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      )
    );

  }

}