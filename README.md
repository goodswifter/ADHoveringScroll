# ADHoveringScroll
#**上滑ScrollView,实现控件顶部悬浮**
因为看到网上写iOS顶部悬浮的Demo特别少,所以做出来之后,发布到网上,仅供参考。

---
## **效果图**
不论怎么滑动屏幕内容，当蓝色部分到达顶部时，便会一直会显示在顶部。
![Result](http://img.blog.csdn.net/20170629174923749?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhvbmdhZDAwNw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

---
##**实现原理**
1. UIScrollView向上滑动时,当OffsetY小于等于最初悬浮框距离导航栏的距离时,将悬浮框添加到TableView的头视图上
2. 否则,将悬浮框添加到控制器的View上

## **主要实现代码**
``` objc
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= TableHeaderH - titleViewH - NavH) {
        // 当向上滑动到状态栏边缘的时候，将红色控件添加到控制器View中
        self.titleView._y = NavH;
        [self.view addSubview:self.titleView];
    } else {
        // 下拉到scrollView顶部时候，将红色控件添加到控制器scrollView中
        self.titleView._y = TableHeaderH - titleViewH;
        [self.tableView.tableHeaderView addSubview:self.titleView];
    }
}
```
