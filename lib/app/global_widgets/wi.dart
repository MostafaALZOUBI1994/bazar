/*
import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/advertisment_model.dart';
import 'package:flutter/material.dart';


class AdvertismentCard extends StatelessWidget {

  final Advertisment planet;
  AdvertismentCard(this.planet);
  @override
  Widget build(BuildContext context) {
    final planetThumbnail =  Container(
      margin: new EdgeInsets.symmetric(
          vertical: 16.0
      ),
      alignment: FractionalOffset.centerLeft,
      child: ClipOval(
        child: new Image(fit: BoxFit.cover,
          image: new NetworkImage(baseUrl+planet.imagess[0].url),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );

    final baseTextStyle = const TextStyle(
        fontFamily: 'Poppins'
    );
    final regularTextStyle = baseTextStyle.copyWith(
        color: const Color(0xffb6b2df),
        fontSize: 9.0,
        fontWeight: FontWeight.w400
    );
    final subHeaderTextStyle = regularTextStyle.copyWith(
        fontSize: 12.0
    );
    final headerTextStyle = baseTextStyle.copyWith(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w600
    );

    Widget _planetValue({String value, String image}) {
      return new Row(
          children: <Widget>[
                       new Container(width: 8.0),
            new Text(planet.name, style: regularTextStyle),
          ]
      );
    }


    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(planet.name, style: headerTextStyle),
          new Container(height: 10.0),
          new Text(planet.price.toString(), style: subHeaderTextStyle),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 8.0),
              height: 2.0,
              width: 18.0,
              color: new Color(0xff00c6ff)
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: _planetValue(
                      value: planet.category,
                      image: 'assets/img/ic_distance.png')

              ),
              new Expanded(
                  child: _planetValue(
                      value: planet.name,
                      image: 'assets/img/ic_gravity.png')
              )
            ],
          ),
        ],
      ),
    );


    final planetCard = new Container(
      child: planetCardContent,
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color:kColorOfBlueRect,
        shape: BoxShape.rectangle,
        
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        )
    );
  }
}
 */