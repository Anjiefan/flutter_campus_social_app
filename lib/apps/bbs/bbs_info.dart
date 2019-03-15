
class BBSInfo {
  String headUrl;
  String user;
  String action;
  String time;
  String title;
  String mark;
  List<String> imgUrl;
  int agreeNum;
  int commentNum;

  BBSInfo(this.headUrl, this.user, this.action, this.time, this.title, this.mark, this.agreeNum, this.commentNum, {this.imgUrl});
}

List<BBSInfo> bbsInfoList = [
  new BBSInfo(
      "https://pic.baike.soso.com/ugc/baikepic2/16720/cut-20180126195517-1168215312_jpg_731_584_26331.jpg/300",
      "王晨星",
      "",
      "2小时前",
      "波斯猫",
      "波斯猫（Persian cat）是以阿富汗的土种长毛猫和土耳其的安哥拉长毛猫为基础，在英国经过100多年的选种繁殖...",
      32, 10,
      imgUrl: ["http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg","https://pic.baike.soso.com/ugc/baikepic2/16720/cut-20180126195517-1168215312_jpg_731_584_26331.jpg/300","https://pic.baike.soso.com/ugc/baikepic2/16720/cut-20180126195517-1168215312_jpg_731_584_26331.jpg/300","https://pic.baike.soso.com/ugc/baikepic2/16720/cut-20180126195517-1168215312_jpg_731_584_26331.jpg/300","https://pic.baike.soso.com/ugc/baikepic2/16720/cut-20180126195517-1168215312_jpg_731_584_26331.jpg/300","https://pic.baike.soso.com/ugc/baikepic2/16720/cut-20180126195517-1168215312_jpg_731_584_26331.jpg/300"]
  ),
  new BBSInfo(
      "http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg",
      "安杰凡",
      "",
      "5小时前",
      "英国短毛猫",
      "英国短毛猫，体形圆胖，四肢粗短发达，毛短而密，头大脸圆，温柔平静，对人友善，极易饲养...",
      38, 13,
      imgUrl:["http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg","http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg","http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg", "http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg", "http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg", "http://img.go007.com/2016/11/27/b250bff5dd7a2b67_3.jpg"]
  ),
  new BBSInfo(
      "https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=31521df69ddda144ce0464e0d3debbc7/8694a4c27d1ed21b33719700a76eddc450da3f9e.jpg",
      "乔布斯",
      "",
      "7小时前",
      "美国银色短毛猫",
      "美国银虎斑猫是一种贵族猫，以银、黑为主体颜色。此猫不是常见的黑白土猫，而是从美国虎斑猫培育出来的猫种...",
      38, 13,
      imgUrl: ["https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=31521df69ddda144ce0464e0d3debbc7/8694a4c27d1ed21b33719700a76eddc450da3f9e.jpg","https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=31521df69ddda144ce0464e0d3debbc7/8694a4c27d1ed21b33719700a76eddc450da3f9e.jpg","https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike92%2C5%2C5%2C92%2C30/sign=31521df69ddda144ce0464e0d3debbc7/8694a4c27d1ed21b33719700a76eddc450da3f9e.jpg"]
  ),
];