import 'package:finerit_app_flutter/apps/profile/components/profile_bbs_status_widget.dart';
import 'package:finerit_app_flutter/beans/award_list.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';

class AwardStatusListItem extends StatelessWidget{
  AwardData awardData;
  int type;
  AwardStatusListItem({Key key
    ,@required this.awardData,
    this.type=1
    }):super(key:key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String level;
    String awardImage;
    int ranking=int.parse(awardData.ranking);
    if(ranking==1){
      level='今日最热';
      awardImage='assets/top_award.png';
    }
    else if(ranking<=3){
      level='火热微文';
      if(ranking==2){
        awardImage='assets/second_award.png';
      }
      else{
        awardImage='assets/third_award.png';
      }
    }
    else if(double.parse(awardData.ranking)>3){
      level='热点微文';
      awardImage='assets/after_second.png';
    }
    Widget widget=new Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Image.asset('$awardImage'
                ,width: 50,
                height: 50,
              ),
              new Column(
                  children: <Widget>[
                    new Text("  " + '$level'  , style: new TextStyle(color: FineritColor.color2_normal)),
                    new Divider(height:5),
                    new Text( "  " +awardData.sincePosted, style: new TextStyle(color: Colors.black54,fontSize: 10,),textAlign:TextAlign.right),

                  ],
                  crossAxisAlignment:CrossAxisAlignment.start
              )
            ],
          ),
          ProfileBBSCard(status: awardData.status,user: awardData.user,sincePosted: awardData.statusSincePosted,type: type,),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 10,bottom: 10,right: 10),
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/smile.png'
                            ,width: 30,
                            height: 30,
                          ),
                          Text(awardData.rankingName,style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ),
                    Expanded(child: Text('')),
                    new Row(
                      children: <Widget>[
                        Image.asset('assets/award_money.png',
                          width: 50,
                          height: 50,
                        ),
                        Text('${double.parse(awardData.money).toStringAsPrecision(4)} 凡尔币',style: TextStyle(color: Colors.pink),),
                      ],
                    ),
                  ],
                ),
                new Container(
                ),


              ],
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(100, 245, 245, 247),
              borderRadius:BorderRadius.circular(10.0),
            ),
          ),



        ],
      ),
    );
    return widget;
  }

}