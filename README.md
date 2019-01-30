# ZTWaterFlowLayout（自定义瀑布流布局）
支持瀑布流列表每个cell行列宽高的自定义实现，头尾视图自定义，列表背景色的自定义

# 用法简介
  通过代理方法设置各个必要和可选参数，cell的高度是必选设置，其它参数可以选择设置，如不设置有默认数值。
## ZTWaterFlowLayoutDelegate
 @required
- (CGFloat)waterflowLayout:(ZTWaterFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;//每个item的高度

@optional
- (CGFloat)columnCountInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;//列数

- (CGFloat)columnMarginInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;//列间距 

- (CGFloat)rowMarginInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;//行间距 

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;//边缘间距

- (CGFloat)headerHeightInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;//头视图高度

- (CGFloat)footerHeightInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;//尾视图高度

- (UIColor *)sectionBackgroundColorInWaterflowLayout:(ZTWaterFlowLayout *)waterflowLayout;//分组列表背景色

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ZTWaterFlowLayout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZTWaterFlowLayout'
```

## Author

sacrifice123, Tao.Zhang@zhan.com

## License

ZTWaterFlowLayout is available under the MIT license. See the LICENSE file for more info.
