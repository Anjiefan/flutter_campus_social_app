# flutter-云智校APP
## 描述
国内首家企业采用纯flutter技术栈研发的大型校园社交类APP，这是一款专属于大学生的APP，一个在此娱乐，学习，社交便可赚钱的平台，内测期间便已拥有2万忠实用户。



### 编程语言
[Dart](https://www.dartlang.org/dart-2 "Dart")	flutter研发的基础语言
[Python](https://www.python.org/downloads/release/python-366/ "Python")  完成APP服务器端研发
[Object-C](https://developer.apple.com/documentation/objectivec "Object-C") 编写例如推送，支付等部分原生插件
[Java](https://www.oracle.com/java/ "Java") 编写例如推送，支付等部分原生插件

------------


### 主要技术架构
[flutter](https://docs.flutter.io/ "flutter") 优势：研发速率甚至高过WAP以及react native 缺陷：对全栈工程师的要求更高，需要略了解原生，有web开发经验甚佳。
[django](https://www.djangoproject.com/ "django") 优势：有一套权限认证，xadmin的可视化管理后台，高拓展性，可根据源码自定义拓展组件，开发高效 劣势：市场上高质量的python工程师较少，技术层次不齐容易写出难以维护的代码。
[djangorestframwork](https://www.django-rest-framework.org/ "djangorestframwork")优势：用于开发移动服务器端，高效且迅速，增删改查四个接口简单的业务逻辑依靠多继承一分钟即可编写完成。劣势：不支持微服务，io效率相对spring系列略低。
[djangorestframwork-finer]( "djangorestframwork-finer") 在djangorestfranmwork的基础上，我们的团队编写了对leancloud的数据业务层的序列化器，以及model层的加固和高阅读化的一套框架，随着进一步开发框架逐渐完善，亦会开源。
[leancloud](https://leancloud.cn "leancloud") 完成数据存储，及时通讯和分布式服务的托管，以及推送。
[beecloud](https://beecloud.cn/ "beecloud") 集成支付宝支付，微信支付，本开源中含有我们编写完集成好的插件。
[bugly](https://bugly.qq.com/v2/ "bugly") 启用bugly完成安卓端热更新。
[mobshare](http://www.mob.com/ "mobshare")使用第三方mobshare集成分享功能，本开源中含有我们编写完集成好的插件。

------------


### APP视频展示
[![ScreenShot](https://www.finerit.com/media/zhanshi.png)](https://ugcbsy.qq.com/uwMROfz0r5zIYaQXGdGnC2dfDmZ5O1zlddyT0ZvrRdAm2x5e/i0849m96hkd.mp4?sdtfrom=v1010&guid=dd8e783680cdbc13b334388f06e0d895&vkey=CC19A6ADF55246150D9169DE053F17C3032D9B9396973A32D85062FA0D04F8C02F18E45AD6E855A6CDFF68508BE0B8592B60FCF22E522C8496AD478460FEB765D7DEC57F25D553AE3A635BBE8985DF2D05CCE4E3B83E4878394CFE95E0F14D9E3D444063E486FEDF2448314EA99BFA23106141D2C76DB7BF)

------------


### APP下载链接
##### android下载地址
##### ios下载地址
[云智校APP官网](https://app.finerit.com/index.html "云智校APP官网")

------------

### flutter编码架构
|--apps 各个业务app的数据层，视图层，采用组件化的前端工程化思想，使用mvvm设计模式<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--app<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--models 单个app的状态管理model<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--states<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--components<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--page.dart<br/>
|--beans 放入网络请求后转换的model<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--bean.dart<br/>
|--commons 一般放入工具集<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--util.dart<br/>
|--extra_apps 放入第三方包，修改源码后放于此<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--page.dart<br/>
|--models 全局数据状态管理的model<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--base_model.dart<br/>
|--icons 弃flutter自带的icons，不够简约<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--icon.dart<br/>
|--state 放入一些需要全局通用的state<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--page_state.dart<br/>
|--style 将app的基础样式取出来放于此<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--style.dart<br/>

------------


### flutter主要的第三方库
 **图片获取，视频获取**<br/>
 [image_picker_saver: ^0.1.0](https://pub.dartlang.org/packages/image_picker_saver)<br/>
**  webview插件**<br/>
 [flutter_webview_plugin: ^0.3.0+2 ]<br/>(https://pub.dartlang.org/packages/flutter_webview_plugin)<br/>
**视频样式插件**<br/>
 [ chewie: 0.8.0  ](https://pub.dartlang.org/packages/chewie)<br/>
 ** flutter异步**<br/>
  [  async: ^2.0.8](https://pub.dartlang.org/packages/async)<br/>
 ** 上拉刷新，下拉刷新**<br/>
   [  flutter_easyrefresh: ^1.0.7 ](https://pub.dartlang.org/packages/flutter_easyrefresh)<br/>
**  图片缓存**<br/>
   [ cached_network_image: ^0.5.0  ]<br/>(https://pub.dartlang.org/packages/cached_network_image)<br/>
 ** 支持网络，电话，短信和电子邮件方案,以及打开其他app**<br/>
    [url_launcher: 4.0.3   ](https://pub.dartlang.org/packages/url_launcher#-readme-tab-)<br/>
 ** 选取多张图片**<br/>
    [  multi_image_picker: ^2.4.11 ](https://pub.dartlang.org/packages/multi_image_picker)<br/>
**  定位**<br/>
  [ amap_location:  ](https://pub.dartlang.org/packages/amap_location)<br/>
  **网络请求库**<br/>
  [   dio: 1.0.13 ](https://pub.dartlang.org/packages/dio)<br/>
**  原生toast**<br/>
  [   fluttertoast:  ](https://pub.dartlang.org/packages/fluttertoast)<br/>
**  获取存储卡**<br/>
 [   shared_preferences: ^0.4.3 ](https://pub.dartlang.org/packages/shared_preferences)<br/>
** 获取存储地址**<br/>
   [   path: ^1.6.2:  ](https://pub.dartlang.org/packages/path)<br/>
 ** 权限管理，建议写一套原生的权限管理，此插件有漏洞**<br/>
    [  simple_permissions ](https://pub.dartlang.org/packages/simple_permissions)<br/>
 ** 相机**<br/>
      [   camera: 0.2.9+1 ](https://pub.dartlang.org/packages/camera)<br/>
 ** mvvm的状态管理**<br/>
   [  scoped_model: ](https://pub.dartlang.org/packages/scoped_model)<br/>
 ** 刷新样式**<br/>
     [  progress_indicators: ^0.1.2 ](https://pub.dartlang.org/packages/progress_indicators)<br/>
  **获取文件位置**<br/>
    [  path_provider: ](https://pub.dartlang.org/packages/path_provider)<br/>
**  录音**<br/>
   [  audio_recorder: ](https://pub.dartlang.org/packages/audio_recorder)<br/>
**  滑动删除动画**<br/>
    [  flutter_slidable: ](https://pub.dartlang.org/packages/flutter_slidable)<br/>
**  播放音频**<br/>
    [  audioplayer: ](https://pub.dartlang.org/packages/audioplayer)<br/>
**  播放视频**<br/>
   [   video_player: 0.7.2: ](https://pub.dartlang.org/packages/video_player)<br/>
   

------------


### 踩坑路程

### 团队
CEO ,CTO,美术总监，数据处理
### 企业
大庆市凡尔网络科技有限责任公司

------------
