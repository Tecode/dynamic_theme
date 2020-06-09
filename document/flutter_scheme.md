# Flutter scheme 使用

## URL scheme的作用

### iOS scheme介绍

我们都知道苹果手机中的APP都有一个沙盒，APP就是一个信息孤岛，相互是不可以进行通信的。但是iOS的APP可以注册自己的URL Scheme，URL Scheme是为方便app之间互相调用而设计的。我们可以通过系统的OpenURL来打开该app，并可以传递一些参数。

例如：你在Safari里输入www.alipay.com，就可以直接打开你的支付宝app，前提是你的手机装了支付宝。如果你没有装支付宝，应该显示的是支付宝下载界面，点击会跳到AppStore的支付宝下载界面。

URL Scheme必须能唯一标识一个APP，如果你设置的URL Scheme与别的APP的URL Scheme冲突时，你的APP不一定会被启动起来。因为当你的APP在安装的时候，系统里面已经注册了你的URL Scheme。

一般情况下，是会调用先安装的app。但是iOS的系统app的URL Scheme肯定是最高的。所以我们定义URL Scheme的时候，尽量避开系统app已经定义过的URL Scheme。

### Android scheme介绍

android中的scheme是一种页面内跳转协议;

通过定义自己的scheme协议，可以非常方便跳转app中的各个页面；

通过scheme协议，服务器可以定制化告诉App跳转到APP内部页面。

## 使用[uni_links](https://pub.dev/packages/uni_links#-installing-tab-)库

### 1 、`pubspec.yaml`文件新增依赖

```dart
dependencies:
  uni_links: 0.4.0
```
### 2 、安装

```dart
flutter pub get

Running "flutter pub get" in dynamic_theme...                       5.8s
Process finished with exit code 0
```

### 3、Dart代码中使用插件

```
import 'package:uni_links/uni_links.dart';
```