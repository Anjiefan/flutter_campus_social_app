Language: [English](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/README-en.md) | [中文简体](https://github.com/Anjiefan/flutter_campus_social_app/edit/master/README.md)
# flutter-python-app
## 云智校APP
国内首家企业采用纯flutter技术栈研发的大型校园社交类APP，这是一款专属于大学生的APP，一个在此娱乐，学习，社交便可赚钱的平台，内测期间便已拥有2万忠实用户。目前1.2版本已经在安卓商店和苹果商店上架。

------------

### 编程语言
[Dart](https://www.dartlang.org/dart-2 "Dart")	flutter研发的基础语言<br/>
[Python](https://www.python.org/downloads/release/python-366/ "Python")  完成APP服务器端研发<br/>
[Object-C](https://developer.apple.com/documentation/objectivec "Object-C") 编写例如推送，支付等部分原生插件<br/>
[Java](https://www.oracle.com/java/ "Java") 编写例如推送，支付等部分原生插件<br/>

------------


### 主要技术架构
[flutter](https://docs.flutter.io/ "flutter") 优势：研发速率甚至高过WAP以及react native 缺陷：对全栈工程师的要求更高，需要略了解原生，有web开发经验甚佳。<br/>
[django](https://www.djangoproject.com/ "django") 优势：有一套权限认证，xadmin的可视化管理后台，高拓展性，可根据源码自定义拓展组件，开发高效 劣势：市场上高质量的python工程师较少，技术层次不齐容易写出难以维护的代码。<br/>
[djangorestframwork](https://www.django-rest-framework.org/ "djangorestframwork")优势：用于开发移动服务器端，高效且迅速，增删改查四个接口简单的业务逻辑依靠多继承一分钟即可编写完成。劣势：不支持微服务，io效率相对spring系列略低。<br/>
[djangorestframwork-finer]( "djangorestframwork-finer") 在djangorestfranmwork的基础上，我们的团队编写了对leancloud的数据业务层的序列化器，以及model层的加固和高阅读化的一套框架，随着进一步开发框架逐渐完善，亦会开源。<br/>
[leancloud](https://leancloud.cn "leancloud") 完成数据存储，及时通讯和分布式服务的托管，以及推送。<br/>
[beecloud](https://beecloud.cn/ "beecloud") 集成支付宝支付，微信支付，本开源中含有我们编写完集成好的插件。<br/>
[bugly](https://bugly.qq.com/v2/ "bugly") 启用bugly完成安卓端热更新。<br/>
[mobshare](http://www.mob.com/ "mobshare")使用第三方mobshare集成分享功能，本开源中含有我们编写完集成好的插件。<br/>

------------


### APP视频展示
[![ScreenShot](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/shiping.png?raw=true)](http://lc-aveFaAUx.cn-n1.lcfile.com/3487931ee9e780d847c4.mp4)

------------


### APP下载链接
##### android下载地址
[![](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/android.png?raw=true)](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/android.png?raw=true)
##### ios下载地址
[云智校APP官网](https://app.finerit.com/ "云智校APP官网")

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


| 第三方库 | 用途 |
|--------|-----|
|[image_picker_saver: ^0.1.0](https://pub.dartlang.org/packages/image_picker_saver)| 图片获取，视频获取 |
|  [flutter_webview_plugin: ^0.3.0+2 ](https://pub.dartlang.org/packages/flutter_webview_plugin) | webview插件|
|[ chewie: 0.8.0  ](https://pub.dartlang.org/packages/chewie)| 视频样式插件 |
|  [  async: ^2.0.8](https://pub.dartlang.org/packages/async) |flutter异步 |
|[  flutter_easyrefresh: ^1.0.7 ](https://pub.dartlang.org/packages/flutter_easyrefresh)| 上拉刷新，下拉刷新|
|[ cached_network_image: ^0.5.0  ](https://pub.dartlang.org/packages/cached_network_image)|图片缓存 |
| [url_launcher: 4.0.3   ](https://pub.dartlang.org/packages/url_launcher#-readme-tab-) | 支持网络，电话，短信和电子邮件方案,以及打开其他app|
| [  multi_image_picker: ^2.4.11 ](https://pub.dartlang.org/packages/multi_image_picker) | 选取多张图片|
| [ amap_location:  ](https://pub.dartlang.org/packages/amap_location)|定位
|[   dio: 1.0.13 ](https://pub.dartlang.org/packages/dio) | 网络请求库 |
| [   fluttertoast:  ](https://pub.dartlang.org/packages/fluttertoast)|原生toast|
|[   shared_preferences: ^0.4.3 ](https://pub.dartlang.org/packages/shared_preferences) | 获取存储卡 |
|  [   path: ^1.6.2:  ](https://pub.dartlang.org/packages/path)| 获取存储地址|
| [  simple_permissions ](https://pub.dartlang.org/packages/simple_permissions)| 权限管理，建议写一套原生的权限管理，此插件有漏洞
|[   camera: 0.2.9+1 ](https://pub.dartlang.org/packages/camera)|相机
| [  scoped_model: ](https://pub.dartlang.org/packages/scoped_model) | mvvm的状态管理 
|[  progress_indicators: ^0.1.2 ](https://pub.dartlang.org/packages/progress_indicators)|刷新样式
|[  path_provider: ](https://pub.dartlang.org/packages/path_provider) | 获取文件位置
|[  audio_recorder: ](https://pub.dartlang.org/packages/audio_recorder)|录音
|[  flutter_slidable: ](https://pub.dartlang.org/packages/flutter_slidable)|滑动删除动画
|[  audioplayer: ](https://pub.dartlang.org/packages/audioplayer)|播放音频
| [   video_player: 0.7.2: ](https://pub.dartlang.org/packages/video_player)|播放视频



------------


### 踩坑总结
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flutter架构能满足我们的基本需求，而且开发效率迅速，开发的过程中编译环境出现的问题算是层出不穷，其中安卓端面临着这种插件版本不兼容的问题，最终我们采取的解决方案是升级到androidx，而ios的编译问题也同样，采取migrate swift至统一版本。其他大大小小的问题，google也都有解决方案，总体上来说没有困扰很久的问题，利用flutter开发，让我们在3个月内完成了我们预算6-9个月原生开发完成的工程（甚至多余的时间我们还完成了测试和调优）。
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;另外很多填过的小坑，因为赶工期我们也没有多做记录，对flutter、python、go研发有兴趣的话可以加入我们的群，一起交流，一起成长，另外打个广告，随着我们公司的逐步扩张，预计19年7月-9月份招收一批flutter开发人员，公司成员普遍为90后高校技术创业者，有合作的兴趣可以长期关注我们。<br/>
[![](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/qqqun.jpg?raw=true)](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/qqqun.jpg?raw=true)

------------
### 6月份2.0版本将推出的产品
1.实名及时通讯系统<br/>
2.匿名匹配交友系统<br/>
3.依赖于大数据和智能爬取的知识资源及全国优质高材生共享的学习圈<br/>


### 企业
大庆市凡尔网络科技有限责任公司<br/>
理念：利用科技颠覆文明，利用科技改变世界。<br/>
email:finerit@163.com<br/>
商业合作联系qq:66064540<br/>

------------
