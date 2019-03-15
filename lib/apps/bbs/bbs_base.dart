import 'package:finerit_app_flutter/apps/bbs/bbs_search_page.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_send2.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_tabs.dart';
import 'package:finerit_app_flutter/apps/bbs/bbs_top_ten_status.dart';
import 'package:finerit_app_flutter/apps/bbs/model/bbs_model.dart';
import 'package:finerit_app_flutter/apps/components/asset.dart';
import 'package:finerit_app_flutter/apps/components/common_drawer.dart';
import 'package:finerit_app_flutter/commons/Api.dart';
import 'package:finerit_app_flutter/commons/NetUtil.dart';
import 'package:finerit_app_flutter/commons/toast.dart';
import 'package:finerit_app_flutter/commons/ui.dart';
import 'package:finerit_app_flutter/icons/icons_route2.dart';
import 'package:finerit_app_flutter/icons/icons_route3.dart';
import 'package:finerit_app_flutter/models/base_model.dart';
import 'package:finerit_app_flutter/style/global_config.dart';
import 'package:finerit_app_flutter/icons/icons_route.dart';
import 'package:finerit_app_flutter/style/themes.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class BBSApp extends StatefulWidget {
  BBSRecommendModel bbsRecommendModel;
  BBSCountryModel bbsCountryModel;
  BBSNeighborhoodModel bbsNeighborhoodModel;
  BBSSchoolModel bbsSchoolModel;
  BBSFriendModel bbsFriendModel;
  BBSApp({Key key,this.bbsCountryModel,this.bbsFriendModel,this.bbsNeighborhoodModel
  ,this.bbsRecommendModel,this.bbsSchoolModel}):super(key:key);
  @override
  State<StatefulWidget> createState() => BBSAppState(
    bbsCountryModel: bbsCountryModel,
    bbsFriendModel: bbsFriendModel,
    bbsNeighborhoodModel: bbsNeighborhoodModel,
    bbsRecommendModel: bbsRecommendModel,
      bbsSchoolModel: bbsSchoolModel
  );
}



class BBSAppState extends State<BBSApp> with SingleTickerProviderStateMixin{
  BBSAppState({key,this.bbsSchoolModel
  ,this.bbsRecommendModel
  ,this.bbsNeighborhoodModel
  ,this.bbsFriendModel
  ,this.bbsCountryModel}):super();
  bool _isSearching = false;
  final TextEditingController _searchQuery = TextEditingController();
  TabController _tabController;

  Widget barSearch() {
    return new Container(
        height: 35,
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new FlatButton.icon(
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) {
                          return ScopedModel<BaseBBSModel>(
                            model: statusTopModel,
                            child: SearchPage(),
                          );
                        }
                    ));
                  },
                  icon: new Icon(
                      MyFlutterApp.search,
                      color: GlobalConfig.font_color,
                      size: 20.0
                  ),
                  label: new Text(
                    "搜索",
                    style: new TextStyle(color: GlobalConfig.font_color),
                  ),
                )
            ),
          ],
        ),
        decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
          color: Color.fromARGB(20, 0, 0, 0),
        )
    );
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  BBSRecommendModel bbsRecommendModel;
  BBSCountryModel bbsCountryModel;
  BBSNeighborhoodModel bbsNeighborhoodModel;
  BBSSchoolModel bbsSchoolModel;
  BBSFriendModel bbsFriendModel;
  List<BaseBBSModel> useablelistModel=[];

  StatusTopModel statusTopModel;
  MainStateModel baseModel;
  void initState() {

    super.initState();
    statusTopModel=StatusTopModel();
    _tabController = new TabController(vsync: this, length: 5);
  }
  void _handleSearchBegin() {
    ModalRoute.of(context).addLocalHistoryEntry(LocalHistoryEntry(
      onRemove: () {
        if(!this.mounted){
          return;
        }
        setState(() {
          _isSearching = false;
          _searchQuery.clear();
        });
      },
    ));
    if(!this.mounted){
      return;
    }
    setState(() {
      _isSearching = true;
    });
  }

  Widget _buildSearchBar() {
    return AppBar(
      leading: BackButton(
        color: Colors.grey[800],
      ),
      title: TextField(
        controller: _searchQuery,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: '搜索Everything',
        ),
        onChanged: _handleSearching,
      ),
      backgroundColor: Theme.of(context).canvasColor,

    );
  }

  Widget _buildAppBar(MainStateModel model) {
    return AppBar(
      bottom: new TabBar(
        tabs: <Widget>[
          Tab(text: "推荐"),
          Tab(text: "全国"),
          Tab(text: "附近"),
          Tab(text: "本校"),
          Tab(text: "关注"),
        ],
        indicatorColor: Colors.grey[400],
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey[400],
        controller: _tabController,
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: new CircleAvatar(
            backgroundImage: new NetworkImage(model.userInfo!=null?model.userInfo.headImg:""),
          ),
          onPressed: () {
            handle_head_event(context);
          },
        ),
      ),
      title: barSearch(),
      backgroundColor: Colors.white,
      actions: <Widget>[
        PopupMenuButton<FilterMenuItem>(
          icon: Icon(MyFlutterApp3.filter, color: FineritColor.color1_normal,size: 20,),
          onSelected: (FilterMenuItem value) {
            _handleFilterMenu(context, value);
          },
          itemBuilder: (BuildContext context) =>
          <PopupMenuItem<FilterMenuItem>>[
            const PopupMenuItem(
              value: FilterMenuItem.TOP,
              child: Text("全球通告"),
            ),
            const PopupMenuItem(
              value: FilterMenuItem.FINERCODE,
              child: Text("赏金趣闻"),
            ),
            const PopupMenuItem(
              value: FilterMenuItem.TIME,
              child: Text("及时动态"),
            ),
          ],
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {

    return new ScopedModelDescendant<MainStateModel>(
        builder: (context, widget,MainStateModel model){
          baseModel=model;
          return Scaffold(

            appBar: _isSearching ? _buildSearchBar() : _buildAppBar(model),
            floatingActionButton: FloatingActionButton(
              child: const Icon(MyFlutterApp2.pen,size: 30,),
              heroTag: null,
              foregroundColor: FineritColor.color1_normal,
              backgroundColor: Colors.white,
              elevation: 7.0,
              highlightElevation: 14.0,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=> Talk(bbsModels: [bbsRecommendModel,bbsCountryModel,bbsNeighborhoodModel,bbsSchoolModel],)
                ));
              },
              mini: false,
              shape: new CircleBorder(),
              isExtended: false,
            ),
            body:

            new TabBarView(
              controller: _tabController,
              children: <Widget>[
                ScopedModel<BaseBBSModel>(

                  model:bbsRecommendModel,
                  child: BBSRecommendTab(

                  ),
                ),
                ScopedModel<BaseBBSModel>(
                  model:bbsCountryModel,
                  child: BBSCountryTab(),
                ),
                ScopedModel<BaseBBSModel>(
                  model:bbsNeighborhoodModel,
                  child: BBSNeighborhoodTab(),
                ),
                ScopedModel<BaseBBSModel>(
                  model:bbsSchoolModel,
                  child: BBSSchoolTab(),
                ),
                ScopedModel<BaseBBSModel>(
                  model:bbsFriendModel,
                  child: BBSFriendTab(),
                ),
              ],
            ),
          );
        }
    );

  }

  void _handleSearching(String searchText) {
    //TODO use searchText as the keyword for searching
    //...
  }
  void handle_nav_top_ten_status(){
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context)=>
            ScopedModel<BBSTopTenModel>(
              model: BBSTopTenModel(),
              child: BBSTopTenApp(),
            )
    ));
  }
  void _handleFilterMenu(BuildContext context, FilterMenuItem value) {

    switch (value) {
      case FilterMenuItem.TOP:
        handle_nav_top_ten_status();
        break;
      case FilterMenuItem.FINERCODE:
      //TODO 赏金趣闻
        bbsRecommendModel=BBSRecommendModel();
        bbsCountryModel=BBSCountryModel();
        bbsNeighborhoodModel=BBSNeighborhoodModel();
        bbsSchoolModel=BBSSchoolModel();
        bbsFriendModel=BBSFriendModel();

        bbsRecommendModel.filterMenuItem=value;
        bbsCountryModel.filterMenuItem=value;
        bbsNeighborhoodModel.filterMenuItem=value;
        bbsSchoolModel.filterMenuItem=value;
        bbsFriendModel.filterMenuItem=value;

        bbsRecommendModel.initData=false;
        bbsCountryModel.initData=false;
        bbsNeighborhoodModel.initData=false;
        bbsSchoolModel.initData=false;
        bbsFriendModel.initData=false;
        var maplist=[
          bbsRecommendModel,
          bbsCountryModel,
          bbsNeighborhoodModel,
          bbsSchoolModel,
          bbsFriendModel
        ];
        maplist[_tabController.index].initData=null;
        if(!this.mounted){
          return;
        }
        setState(() {

        });
        requestToast('过滤模式，过滤掉不含凡尔币的文章');
        break;
      case FilterMenuItem.TIME:
      //TODO 及时动态
        bbsRecommendModel=BBSRecommendModel();
        bbsCountryModel=BBSCountryModel();
        bbsNeighborhoodModel=BBSNeighborhoodModel();
        bbsSchoolModel=BBSSchoolModel();
        bbsFriendModel=BBSFriendModel();
        bbsRecommendModel.filterMenuItem=value;
        bbsCountryModel.filterMenuItem=value;
        bbsNeighborhoodModel.filterMenuItem=value;
        bbsSchoolModel.filterMenuItem=value;
        bbsFriendModel.filterMenuItem=value;
        bbsRecommendModel.initData=false;
        bbsCountryModel.initData=false;
        bbsNeighborhoodModel.initData=false;
        bbsSchoolModel.initData=false;
        bbsFriendModel.initData=false;

        var maplist=[
          bbsRecommendModel,
          bbsCountryModel,
          bbsNeighborhoodModel,
          bbsSchoolModel,
          bbsFriendModel
        ];
        maplist[_tabController.index].initData=null;
        if(!this.mounted){
          return;
        }
        setState(() {

        });
        requestToast('非过滤模式，获取所有动态');
        break;
    }
  }



}
