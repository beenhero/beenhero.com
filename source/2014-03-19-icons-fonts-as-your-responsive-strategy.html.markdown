---
title: "响应式Web图形篇 —— icon fonts 的探析及应用"
date: 2014-03-19 20:37 +08:00
tags: Tutorial, Tech, Design,
author: ben
---

<aside class="aside-block">
  <blockquote>
    <p>当下互联网设备「风起云涌」，显示分辨率「层出不穷」，为 Web 创建者们带来越来越多的难题……</p>
  </blockquote>
</aside>

## 前言

像素完美（Pixel Perfection）、分辨率无关（Resolution Independent）和多平台体验一致性是设计师们的追求。
可访问性（Accessability）、加载性能和重构灵活性是前端工程师们关心的主题。

当下互联网设备「风起云涌」，显示分辨率「层出不穷」，为 Web 创建者们带来越来越多的难题。

  * 需要为高PPI（aka Retina）显示设备准备@1.5x、@2x、@3x的图片素材；
  * 需要针对不同显示屏分辨率来调整优化排版；
  * 需要考虑多个分辨率版本的图片的加载性能问题；
  * 设备版本碎片化（Version Segmentation）带来的语义和可访问性的问题；
  * ……

## 响应式设计

![Responsive Design](2014-03-19/responsive-design.png)

响应式设计（Responsive Design）作为「救世主」的身份，已经在 Web 界布道了好几年，丝毫不亚于当年的「Ajax」先生。其核心就是：针对不同设备和应用场景，作出合理性的适应。狭义地看，就是 Web page 在不同分辨率下借助 media query 来调整页面布局和内容显示，三个关键词是：Fluid grids, Flexible images, Media queries.

其中 Flexible images 是最为棘手的地方。因为前面提到，现在的设备多样化，不同分辨率和不同 PPI 给图片自适应带来了空前复杂度。目前还没有一套完美的解决方案来应对，W3C那边还在拟定 [Responsive Images](http://www.w3.org/community/respimg/) 和 [Picture Element](http://www.w3.org/TR/2013/WD-html-picture-element-20130226/) 的相关标准。但在这之前你需要采取多管齐下的方式，针对媒体元素不同的使用场景，制定不同的自适应策略。目前主要有三种主流方式：

  1. max-width: 100% 来自适应容器  
       同一张图片，在不同容器里，自动适应到容器的大小。存在的问题是，大尺寸图片在小尺寸屏幕下的带宽浪费和加载速度慢。

  2. 多版本图片更换
      - 针对写在CSS里的background-image，可以借助 media query 来适应显示 @1x 或 @2x 的版本。
      - 针对 HTML <img> 里的图片可以利用 [Piturefill.js](https://github.com/scottjehl/picturefill) 来做自适应。
   
  3. 使用矢量化图形，包括
      - icon fonts
      - SVG

这一期我们主要来讲讲 icon fonts 的应用。

## 什么是 icon fonts?

利用字体工具把我们平时 Web 上用的图形图标（icons）转换成 web fonts，就成了 icon fonts，它可以借助 CSS 的 @font-face 嵌入到网页里，用以显示 icons。因为字体是矢量化图形，它天生具有「分辨率无关」的特性，在任何分辨率和PPI下面，都可以做到完美缩放，不会像传统位图，如：png，jpeg，放大后有锯齿或模糊现象。

![Mac 30 years icon fonts](2014-03-19/mac-30th-icon-fonts.jpg)

注：上图是 Apple 纪念 Mac 发布[30周年网站](http://www.apple.com/30-years/)截图，网页内大量运用了 icon fonts 来塑造不同年代发布的产品，这类 iOS 7 引入的线条风格图标，使用 icon fonts 来表现最合适不过了。

## 为什么要用 icon fonts？

除了「分辨率无关」这个最大的优点之外，icon fonts 还具有：

  * **文件小**：相比图片几十几百KB的容量，icon fonts 几乎是羽翼级轻量。
  * **加载性能好**：因为图标都被打包进一套字体内，http request 减少。这如同我们常用的 css sprites 技术。
  * **支持CSS样式**：和普通字体一样，你可以利用CSS来定义大小、颜色、阴影、hover状态、透明度、渐变等等...
  * **兼容性好**：web fonts 起源很早，别说主流浏览器，连IE6/7都能良好支持。除了一些老的移动端浏览器，如Android 2.1以下的初代浏览器，Opera mini 这类自限型浏览器。

![icon fonts 文件大小](2014-03-19/icon-fonts-list.jpg)

当然 icon fonts 也有它的不足：

 * 样式单一，无法针对不同分辨率来调整icon 的细节，比如降低大尺寸icon 的线条粗细。
 * 颜色单一，CSS 无法方便的去定义彩色的 icon，倒是有通过[叠加组合](forecastfont.iconvau.lt)的方式来达到彩色图标的目的。
 * 移动端浏览器兼容性还不够完善，像Opera mini、Windows phone 7.0-7.8 都不能正常显示icon fonts。
 * 有少量的移动设备有可能会和 icon fonts 的字符编码冲突，导致icon 显示不正常（我们自己风车Android 版本就碰到了这个问题）。

所以 icon fonts 也并不是一套完美的响应式图片的解决方案，当它适宜你的应用场景时，比如：

 * 你的网站是扁平化或简约风格，图标样式单一，颜色为纯色。
 * 你的目标用户使用桌面浏览器为主，或者，
 * 你愿意为非兼容设备做兼容hack。
 
那么 icon fonts 是一个令设计师和前端工程师都心花怒放的方案。

## 如何制作 icon fonts？

icon fonts 的制作主要有两条思路：

  1. 利用字体工具手动制作
  2. 利用在线工具自动生成

### 手动制作
在icon fonts 自动生成器没有诞生之初，大家只能依靠字体编辑软件来完成icon fonts 的制作，简单介绍一下手动制作的流程。
 
<aside class="aside">
  ![Glyphs App snapshot](2014-03-19/text_and_drawing.gif)
</aside>

 1. 在 illustrator 或 Sketch 这类矢量图形软件里创建你的 icon。
 2. 然后把 icon 一个一个导入到字体编辑工具，转换成 glyphs 进行编辑，设置对应的 unicode 编码。常用字体工具有：
    * [Glyphs](http://www.glyphsapp.com/)
    * [FontForge](http://fontforge.org/)
    * [FontCreator](http://www.high-logic.com/font-editor/fontcreator.html)

 3. 完成glyphs 编辑后，从字体工具导出 OTF 字体文件，然后利用 [Font Squirrel](http://www.fontsquirrel.com/tools/webfont-generator) 生成器来生成 web fonts 支持的格式。
  
手动制作 icon fonts 需要具备一定字体设计的知识，如有兴趣可作尝试。而自动生成工具用起来就傻瓜和省心多了。

### 自动生成
我们「[风车](https://fengche.co)」去年底进行了一次改版，其中一项就是把原来位图图标全部转换成 icon fonts，当时采用的是阿里巴巴提供的免费在线工具 [iconfont.cn](http://www.iconfont.cn/)。

<aside class="aside">
  ![Alibaba iconfont.cn](2014-03-19/alibaba-icon-fonts-cn.jpg)
</aside>

>  Iconfont.cn是由阿里巴巴UX部门推出的矢量图标管理网站，也是国内首家推广Webfont形式图标的平台。网站涵盖了1000多个常用图标并还在持续更新中，Iconfont平台为用户提供在线图标搜索、图标分捡下载、在线储存、矢量格式转换、个人图标库管理及项目图标管理等基础功能。

「风车」应用内的图标有两个来源： 一些从开源图标库拿来，一些是设计师自己制作。接下来详细介绍一下，我们是如何利用 iconfont.cn 这个在线工具生成了这 56 个图标的 icon fonts。

![风车App icon fonts](2014-03-19/fengche-co-icon-fonts.jpg)

#### 步骤一
参照 iconfont.cn 提供的图标制作模版，在Illustrator 画布的16x16网格内，参考基线、上升部、下降部来调整图标大小和位置。

<aside class="aside">
  ![SVG 图标大小位置调整](2014-03-19/svg-icon-tweak-guideline.jpg)
</aside>

调整矢量图标需要注意几点：

  1. 图形需要闭合，不要用stroke，否则会显示不出来
  2. 图形合并并扩展
  3. 用单色
  4. 在16x16画布中进行排版，这样制作好的icon fonts 16px 大小的时候和其它字体保持一致。

#### 步骤二
然后从Illustrator 保存为SVG文件，使用默认的SVG设置即可。
![Illustrator 保存为SVG](2014-03-19/illustrator-save-as-svg.jpg)

#### 步骤三

你可以拖动一个或多个SVG图标到iconfont.cn 的上传表单，完成上传后会提示设置名称和tag，点击「完成上传」开始生成icon fonts 。生成完成后，你可以点击要下载的图标加入购物车，然后「下载至本地」。
![拖动上传svg文件](2014-03-19/step3-upload-all-svg-files.png)

#### 步骤四
解压刚下载的文件包，除了EOT、SVG、TTF、WOFF四种 web fonts 字体外，还有个 demo.html 展示所有 icons 及其对应的字体编码。之所以有4种字体格式，是考虑到不同浏览器不同平台对字体格式的支持不一样，具体看下面 CSS 里的注解。

复制4个字体文件到 assets 或 fonts 目录下，然后在 CSS 文件加入 @font-face 声明(注意更改字体所在的文件路径)。

```
@font-face {font-family: 'iconfont';
    src: url('iconfont.eot'); /* IE9*/
    src: url('iconfont.eot?#iefix') format('embedded-opentype'), /* IE6-IE8 */
    url('iconfont.woff') format('woff'), /* chrome、firefox */
    url('iconfont.ttf') format('truetype'), /* chrome、firefox、opera、Safari, Android, iOS 4.2+*/
    url('iconfont.svg#uxiconfont') format('svg'); /* iOS 4.1- */
}

```

再定义一个 ```icon-*``` 通配我们所有图标的共有 CSS 样式，

```
[class^="icon-"], [class*=" icon-"] {
  display: inline-block;
  speak: none
  font-family: "iconfont";
  font-size: 16px;
  line-height: 1;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
```

最后是利用 :before 来注入每个 icon 对应的字体编码

```
.icon-bell:before {
  content: "\003432";
}
.icon-search:before {
  content: "\003433";
}
```
现在你可以这样显示一个铃铛图标：

```
<i class="icon-bell"></i>
```

下图就是我们「风车」应用 icon fonts 的实例。
![风车使用 icon fonts](2014-03-19/fengche-co-use-icon-fonts-snapshot.jpg)

#### icon fonts 移动端应用
前面提到， icon fonts 在移动端的兼容性稍微差一点，有几个问题：

  1. 浏览器根本不支持  

  举例 Opera mini，在移动设备和带宽比较落后的地方，用户量还是很大的，如果你的网站访问数据里这类浏览器流量不可忽视，那么你就需要额外处理 icon fonts 的向下兼容，比如 js 嗅探后用雪碧图（CSS spirtes）替代。

  各平台 icon fonts 的兼容情况，参见这张网友测试汇集的[表格](https://docs.google.com/spreadsheet/ccc?key=0Ag5_yGvxpINRdHFYeUJPNnZMWUZKR2ItMEpRTXZPdUE#gid=0)。

  2. unicode 冲突问题  

  一般情况下，icon fonts 生成器会使用 PUA（[Private Unicode Area](http://en.wikipedia.org/wiki/Private_Use_Areas)）这个安全区域的字符编码（code point）。PUA 是专门预留「私用」的 unicode 区间, 一般会用 U+E000..U+F8FF 这个 <a href="http://en.wikipedia.org/wiki/Plane_(Unicode)#Basic_Multilingual_Plane" target="_blank">BMP</a> 区间里预留的 PUA code point. 

  比如： 这个Apple 平台特有的字符，就是用 U+F8FF 这个code point 来对应的，在其它平台就看不到那个字符。

  阿里巴巴的 iconfont.cn 没有遵循这个最佳实践，用得的是 CJK 编码区间（U+3432），所以当你浏览器加载字体出问题时，会还原成一些奇怪的中文文字，这对读屏软件也非常不友好。好在它的管理后台，可以手动的编辑这个 code point。

  另外，如果发现有 icon 显示不出来，或被替换成了其它字符，那么更换一下 code point 可能可以快速的解决。

关于如何应用 icon fonts 到原生的 iOS/Android App 中去，iconfont.cn 上面有[具体的教程](http://www.iconfont.cn/help/iconuse.html)，可以查看一下。

#### 其它 icon fonts 工具
类似 iconfont.cn 这类在线生成工具有很多，就不再一一详细介绍，最著名的还有：

 * [icomoon](http://icomoon.io/)
 * [fontfello](http://fontello.com/)

这些工具基本功能类似，但有少许功能差别，像 icomoon 还支持字体的连字（Ligatures）功能。通过设置 「bell」为铃铛图标的连字，当你在文本中写 「bell」时自动转换成铃铛图标。像 [fontfello](https://github.com/fontello/fontello) 是开源软件，意味着更加灵活和定制的可能性。

如果你对使用英文软件完全没有障碍，我强烈建议使用 icomoon，体验和功能都非常强大。当然作为国内的同行，还是要支持一下 iconfont.cn。

## 结语
icon fonts 作为 web fonts 的一种「特殊」应用，很好的解决了「响应式设计」中图形无损自适应的难题。设计师不再需要维护不同大小、不同颜色的多版本素材，图形矢量化之后，交给那些在线生成器就可以了。对于前端工程师，利用 HTML+CSS 就可以灵活的使用成百上千种图标，无需担心切图、定位、优化等传统位图要应付的情况。而用户，简洁、清晰的图标带给他们赏心悦目的感觉之外，浏览网站的速度体验也将大大提升。

----

<span class="footnotes">
<small>Image credit: [Responsive Design](http://www.webtechlearning.com/responsive-web-designing-program/).</small>
</span>
