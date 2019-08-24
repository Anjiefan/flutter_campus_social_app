# flutter-python-app
## 云智校APP 3.0
Cloud smart school app is the first large-scale campus trade and community app developed by a domestic enterprise using flutter technology stack. Cloud smart school is a software with the core product concept of providing part-time tasks to college students, promoting independent trade of campus students, reducing daily expenses of students, and helping to collect and provide income channels for students.

------------

### Programming language
[Dart](https://www.dartlang.org/dart-2 "Dart")	The basic language developed by flutter<br/>
[Python](https://www.python.org/downloads/release/python-366/ "Python")  Complete APP server development<br/>
[Object-C](https://developer.apple.com/documentation/objectivec "Object-C") Write some native plugins such as push, payment, etc.<br/>
[Java](https://www.oracle.com/java/ "Java") Write some native plugins such as push, payment, etc.<br/>

------------


### Main technical architecture
[flutter](https://docs.flutter.io/ "flutter") Advantages: R&D rate is even higher than WAP and react native defects: higher requirements for full-stack engineers, a little understanding of native, and good web development experience.<br/>
[django](https://www.djangoproject.com/ "django") Advantages: There is a set of authority authentication, xadmin's visual management background, high scalability, can be customized according to the source code to expand the components, develop high-efficiency disadvantages: there are few high-quality python engineers on the market, the technical level is not easy to write difficult to maintain code .<br/>
[djangorestframwork](https://www.django-rest-framework.org/ "djangorestframwork")Advantages: It is used to develop mobile server, efficient and rapid, add, delete and change four interfaces. Simple business logic can be completed by one-minute inheritance. Disadvantages: Microservices are not supported, and io efficiency is slightly lower than the spring series.<br/>
[djangorestframwork-finer]( "djangorestframwork-finer") Based on djangorestfranmwork, our team has written a serializer for the data business layer of leancloud, as well as a set of frameworks for the reinforcement and high reading of the model layer. As the further development framework is gradually improved, it will also be open source.<br/>
[leancloud](https://leancloud.cn "leancloud") Complete data storage, timely communication and hosting of distributed services, and push.<br/>
[beecloud](https://beecloud.cn/ "beecloud") Integrated Alipay payment, WeChat payment, this open source contains the integrated plugin we have compiled.<br/>
[bugly](https://bugly.qq.com/v2/ "bugly") Enable bugly to complete the Android side hot update.<br/>
[mobshare](http://www.mob.com/ "mobshare")Using a third-party mobshare integration sharing feature, this open source contains the integrated plugin we have written.<br/>


------------

### APP Website
[云智校APP](https://app.finerit.com/ "云智校APP")

------------

### APP Download 
##### android Download
[![](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/android.png?raw=true)](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/android.png?raw=true)
##### ios Download
[![](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/ios1.png?raw=true)](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/ios1.png?raw=true)



------------


### flutter Coding architecture
|--apps Data layer and view layer of each business app, using componentized front-end engineering ideas, using mvvm design pattern<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--app<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--models State management model for a single app<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--states<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--components<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--page.dart<br/>
|--beans Model converted after placing a network request<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--bean.dart<br/>
|--commons Generally put into the toolset<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--util.dart<br/>
|--extra_apps Put in a third-party package, modify the source code and put it here.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--page.dart<br/>
|--models Global data state management model<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--base_model.dart<br/>
|--icons Give up the icons that flutter comes with, not simple enough<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--icon.dart<br/>
|--state Put some states that need to be globally common<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--page_state.dart<br/>
|--style Take the basic style of the app and put it here.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;|--style.dart<br/>

------------


### Flutter's main third-party library


| third-party library | use |
|--------|-----|
|[image_picker_saver: ^0.1.0](https://pub.dartlang.org/packages/image_picker_saver)| Image acquisition, video acquisition |
|  [flutter_webview_plugin: ^0.3.0+2 ](https://pub.dartlang.org/packages/flutter_webview_plugin) | webview plugin|
|[ chewie: 0.8.0  ](https://pub.dartlang.org/packages/chewie)| Video style plugin |
|  [  async: ^2.0.8](https://pub.dartlang.org/packages/async) |flutter asynchronous |
|[  flutter_easyrefresh: ^1.0.7 ](https://pub.dartlang.org/packages/flutter_easyrefresh)| Pull-up refresh, pull-down refresh|
|[ cached_network_image: ^0.5.0  ](https://pub.dartlang.org/packages/cached_network_image)|Image cache |
| [url_launcher: 4.0.3   ](https://pub.dartlang.org/packages/url_launcher#-readme-tab-) | Support network, phone, SMS and email programs, as well as open other apps|
| [  multi_image_picker: ^2.4.11 ](https://pub.dartlang.org/packages/multi_image_picker) | Select multiple images|
| [ amap_location:  ](https://pub.dartlang.org/packages/amap_location)|Positioning
|[   dio: 1.0.13 ](https://pub.dartlang.org/packages/dio) | Network request library |
| [   fluttertoast:  ](https://pub.dartlang.org/packages/fluttertoast)|Native toast|
|[   shared_preferences: ^0.4.3 ](https://pub.dartlang.org/packages/shared_preferences) | Get a memory card |
|  [   path: ^1.6.2:  ](https://pub.dartlang.org/packages/path)| Get storage address|
| [  simple_permissions ](https://pub.dartlang.org/packages/simple_permissions)|Rights management, it is recommended to write a set of native rights management, this plugin has a vulnerability
|[   camera: 0.2.9+1 ](https://pub.dartlang.org/packages/camera)|camera
| [  scoped_model: ](https://pub.dartlang.org/packages/scoped_model) | Mvvm state management 
|[  progress_indicators: ^0.1.2 ](https://pub.dartlang.org/packages/progress_indicators)|Refresh style
|[  path_provider: ](https://pub.dartlang.org/packages/path_provider) | Get file location
|[  audio_recorder: ](https://pub.dartlang.org/packages/audio_recorder)|recording
|[  flutter_slidable: ](https://pub.dartlang.org/packages/flutter_slidable)|Slide delete animation
|[  audioplayer: ](https://pub.dartlang.org/packages/audioplayer)|Play audio
| [   video_player: 0.7.2: ](https://pub.dartlang.org/packages/video_player)|Play video



------------


### Stepping on the pit
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The flutter architecture can meet our basic needs, and the development efficiency is rapid. The problems in the compilation environment during the development process are endless. The Android side faces the problem of incompatibility of the plug-in version. Finally, the solution we adopted is to upgrade to androidx. And the ios compilation problem is the same, take the migrate swift to the unified version. Other big and small problems, google also has a solution, in general, there is no problem that has been plagued for a long time, using flutter development, let us complete the project of 6-9 months of our original development in 3 months (even We also completed the test and tuning for the extra time).
<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In addition, many filled pits, because we did not make more records during the construction period, if you are interested in flutter, python, go development, you can join our group, communicate together, grow together, and make an advertisement, along with our company. Gradually expanding, it is expected that a batch of flutter developers will be recruited from July to September of the year. The members of the company are generally technical entrepreneurs of the post-90s colleges and universities, and they have the interest of cooperation to pay attention to us for a long time.<br/>
[![](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/qqqun.jpg?raw=true)](https://github.com/Anjiefan/flutter_campus_social_app/blob/master/qqqun.jpg?raw=true)

------------
### Version 4.0 will be released in October
1. The bottom layer completes the chain on the alliance chain.

2. Integrated multi-platform part-time job.

3. Equal business cooperation through alliance chain and multiple platforms.

4. Complete the cooperation of part-time job module optimization.


### Company
大庆市凡尔网络科技有限责任公司<br/>
Company vision: to improve the human capacity of the public, to give freelancers creative space.

Company mission: to help users save costs, increase user income, provide diversified channels for individual users, and serve ordinary users as the initial mission of the enterprise; To help small and medium-sized enterprises and individual entrepreneurs to integrate user resources, technical resources, human resources and other resources for the enterprise medium-term mission; The ultimate mission of the enterprise is to enhance social innovation power, social labor productivity and mass life happiness index.

Company core values: change life with technology, and subvert the future with technology.

Daqing faner network technology co. LTD
email:finerit@163.com<br/>
Business cooperation qq:66064540<br/>

------------
