import ListMenuItem from '../../component/ListMenuItem'
import WechatToolbar2 from '../../component/WechatToolbar2'
import { ToastUtils } from '../../utils/ToastUtils';

@Preview
@Component
export default struct Discovery {

  @State isMenuVisible: boolean = false;

  build() {
    Column() {
      // WechatToolbar({ title: "发现" , isMenuVisible: this.isMenuVisible})
      WechatToolbar2({ title: "发现" })

      ListMenuItem({
        title: "朋友圈",
        newsNumber: 2,
        iconSrc: $r('app.media.ic_moment')
      })
        .onClick(unDevTip)

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({
        title: "视频号",
        iconSrc: $r('app.media.ic_video')
      })
        .onClick(unDevTip)

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({
        title: "直播",
        iconSrc: $r('app.media.ic_circle')
      })
        .onClick(unDevTip)

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({
        title: "扫一扫",
        iconSrc: $r('app.media.ic_scan_black')
      })
        .onClick(unDevTip)

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({
        title: "听一听",
        iconSrc: $r('app.media.ic_listen'),
        news: "朋友也在听",
        newsIconSrc: $r('app.media.user_head_mm')
      })
        .onClick(unDevTip)

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({
        title: "购物",
        iconSrc: $r('app.media.ic_shopping')
      })
        .onClick(unDevTip)

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({
        title: "游戏",
        iconSrc: $r('app.media.ic_game')
      })
        .onClick(unDevTip)

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)

      ListMenuItem({
        title: "小程序",
        iconSrc: $r('app.media.ic_miniprogram')
      })
        .onClick(unDevTip)

    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f0f0f0")
  }
}

const unDevTip = () => {
  ToastUtils.show("该功能尚未开发...")
}
