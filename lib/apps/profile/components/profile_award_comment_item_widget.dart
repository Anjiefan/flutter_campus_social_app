import 'package:finerit_app_flutter/apps/profile/components/profile_bbs_comment_widget.dart';
import 'package:finerit_app_flutter/apps/profile/components/profile_bbs_status_widget.dart';
import 'package:finerit_app_flutter/beans/award_list.dart';
import 'package:finerit_app_flutter/beans/base_user_item.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
class AwardCommentListItem extends StatelessWidget{
  AwardData awardData;
  AwardCommentListItem({Key key
    ,@required this.awardData
    }):super(key:key);
  @override
  Widget build(BuildContext context) {
    Widget widget=new Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Image.asset('assets/great_comment_award.png'
                ,width: 50,
                height: 50,
              ),
              new Column(
                  children: <Widget>[
                    new Text("  " + '最佳评论'  , style: new TextStyle(color: FineritColor.color2_normal)),
                    new Divider(height:5),
                    new Text( "  " +awardData.sincePosted, style: new TextStyle(color: Colors.black54,fontSize: 10,),textAlign:TextAlign.right),

                  ],
                  crossAxisAlignment:CrossAxisAlignment.start
              )
            ],
          ),
          ProfileBBSCard(status: awardData.status,user: awardData.status.userId,sincePosted: awardData.statusSincePosted,),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.only(left: 10,bottom: 10,right: 10),
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.only(right: 5),
                      alignment: Alignment.center,
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
                          Text('神评',style: TextStyle(color: Colors.white),),
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
                        Text('${awardData.money} 凡尔币',style: TextStyle(color: Colors.pink),),
                      ],
                    ),
                  ],
                ),
                new Container(

                  child: AwardCommentCard(
                      sincePosted: awardData.commentSincePosted,
                      commentAward: awardData.comment
                      ,user: awardData.user),
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