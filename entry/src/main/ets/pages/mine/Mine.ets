import router from '@ohos.router'
import ListMenuItem from '../../component/ListMenuItem'
import { PhotoPickerUtils } from '../../utils/PhotoPickerUtils'
import WindowManager from '../../utils/WindowManager'
import { ToastUtils } from '../../utils/ToastUtils'

@Preview
@Component
export default struct Mine {
  @State imgPath: string = ""

  build() {
    Column() {
      Row() {
        Column() {
          Image(this.imgPath ? this.imgPath : $r('app.media.myPic'))
            .width(70)
            .height(70)
            .margin({ left: 20 ,right: 10 })
            .borderRadius(8)
            .onClick(() => {
              router.pushUrl({ url: 'pages/mine/MyPicture'
              })
            })
        }
        .margin({ top: 40 })

        Column() {
          Text("GOODMORNING")
            .fontColor(Color.Black)
            .fontSize(20)
            .fontWeight(700)

          Text("微信号：Jiayougaoyi")
            .fontColor(Color.Grey)
            .fontSize(15)
            .margin({ top: 15 })

        }
        .margin({ top: 40 })
        .alignItems(HorizontalAlign.Start)

        Blank()

        Image($r('app.media.ic_qrcode'))
          .width(16)
          .height(16)
          .margin({ top: 38, right: 20 })

        Image($r("app.media.ic_more"))
          .width(9)
          .height(17)
          .margin({ top: 38, right: 15 })
      }
      .width("100%")
      .height(180)
      .backgroundColor(Color.White)
      .padding({ top: WindowManager.statusBarHeight })
      .onClick(() => {
        router.pushUrl({ url: 'pages/qrcode/MyQrCodePage' })
      })

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "服务",
        iconSrc: $r('app.media.ic_service'),
      })
        .onClick(unDevTip)
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "收藏",
        iconSrc: $r("app.media.ic_collect")
      })
        .onClick(unDevTip)

      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "朋友圈",
        iconSrc: $r('app.media.ic_moment_pic')
      })
        .onClick(unDevTip)
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "卡包",
        iconSrc: $r('app.media.ic_card_pkg')
      }).onClick(unDevTip)
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(1)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "表情",
        iconSrc: $r('app.media.ic_face_icon')
      }).onClick(unDevTip)
      Divider()
        .vertical(false)
        .color("#f3f3f3")
        .strokeWidth(10)
        .lineCap(LineCapStyle.Round)
      ListMenuItem({
        title: "设置",
        iconSrc: $r('app.media.ic_setting')
      })
        .onClick(unDevTip)
    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f0f0f0")

  }
}

const unDevTip = () => {
  ToastUtils.show("敬请期待...")
}
