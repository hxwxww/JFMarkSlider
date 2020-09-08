# JFMarkSlider

非常好用的带刻度的Slider

## 截图

![image](https://github.com/hxwxww/JFMarkSlider/raw/master/screenshots/screenshot.gif)

## 导入:

#### 使用`cocoaPods`:

```
pod 'JFMarkSlider'
```

#### 使用`swift package manager`:

依次点击Xcode菜单：

`File` -> `Swift Packages` -> `Add Package Dependency`

在输入框中输入：`https://github.com/hxwxww/JFMarkSlider.git`


## 用法

#### 基本用法：

- 代码如下：

```
    slider.minimumMarkTintColor = .black
    slider.maximumMarkTintColor = .lightGray
    slider.isStayToMark = true
    slider.markStyle = .image(image: UIImage(named: "bullet")!.withRenderingMode(.alwaysTemplate))
    slider.markValues = [0.2, 0.4, 0.6, 0.8]
```

更具体的用法及参数设置，请下载 Demo 查看。
