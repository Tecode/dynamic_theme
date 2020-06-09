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

## Android 配置

**⚠️注意：Scheme 命名不支持`dynamic_theme`在`iOS`中测试了一下无法打开,改成了全小写`dynamictheme`**

### `android/app/src/main/AndroidManifest.xml`

**新增以下代码[查看完整代码]()**

```dart
<!-- Deep Links -->
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <!-- Accepts URIs that begin with YOUR_SCHEME://YOUR_HOST -->
    <data
          android:scheme="[YOUR_SCHEME]"
          android:host="[YOUR_HOST]" />
</intent-filter>
```

**例子：**

```dart
<intent-filter>
 <action android:name="android.intent.action.VIEW"/>
  <category android:name="android.intent.category.DEFAULT"/>
  <category android:name="android.intent.category.BROWSABLE"/>
  <data android:scheme="dynamictheme"/>
  <data 
        android:host="detail"
        android:scheme="dynamictheme"/>
</intent-filter>
```

## iOS 配置

### 打开`Xcode->Info->URL Types`设置`URL Scheme`

添加完也直接反应到配置文件`info.plist`中了，当然你要是觉得自己很厉害，也可以直接在`info.plist`添加。

<p align="center">
    <img width="1400" title="Xcode->Info->URL Types" src="../assets/preview/xcode_scheme.png">
</p>

**`ios/Runner/Info.plist`**

```dart
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
...
<!-- 其它配置 -->
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>dynamictheme</string>
			</array>
		</dict>
	</array>
...
<!-- 其它配置 -->
</dict>
</plist>

```

## Scheme [跳转 index.html](./document/index.html)
```html
<!doctype html>
<html lang="zh-cn">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Scheme 跳转</title>
</head>
<style>
    h3,
    p {
        text-align: center;
    }
</style>

<body>
    <h3>
        <a href="dynamictheme://"> 打开App(dynamictheme://) </a>
        <a href="dynamictheme://detail"> 打开App跳转到详情页面 </a>
    </h3>
    <p>dynamictheme://</p>
    <h3>
    </h3>
    <p>dynamictheme://detail</p>
    <h3>
        <a href="dynamictheme://detail?name=flutter">
            打开App跳转到详情页面带上参数
        </a>
    </h3>
    <p>dynamictheme://detail?name=flutter</p>
</body>

</html>
```


## iOS 效果预览

### 未打开App（开启以后跳转）

<p align="center">
    <img width="200" title="ios_scheme_open" src="../assets/preview/ios_scheme_open.gif">
</p>


### 已打开App（监听Scheme）

<p align="center">
    <img width="200" title="ios_scheme_listen" src="../assets/preview/ios_scheme_listen.gif">
</p>

## Android 效果预览

### 未打开App（开启以后跳转）

<p align="center">
    <img width="200" title="android_scheme_open" src="../assets/preview/android_scheme_open.gif">
</p>


### 已打开App（监听Scheme）

<p align="center">
    <img width="200" title="android_scheme_listen" src="../assets/preview/android_scheme_listen.gif">
</p>