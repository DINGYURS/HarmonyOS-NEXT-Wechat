import Toolbar from '../../component/Toolbar'

@Entry
@Component
struct MyQrCodePage {
  private value: string = 'https://u.wechat.com/MH3hfKOWhpm0eoSb1IheAA0'

  build() {
    Column() {
      Toolbar({ title: "" })
      Row() {
        Image($r('app.media.myPic'))
          .width(60)
          .height(60)
          .margin({ right: 10 })
          .borderRadius(6)

        Column() {
          Text("GOODMORNING")
            .fontColor(Color.Black)
            .fontSize(20)
            .fontWeight(500)

          Text("浙江 嘉兴")
            .fontColor(Color.Grey)
            .fontSize(15)
            .margin({ top: 10 })
        }
        .alignItems(HorizontalAlign.Start)

      }
      .width(280)
      .margin({ top: 100 })

      Stack() {
        QRCode(this.value)
          .width(280)
          .height(280)
          .color(Color.Black)
          .backgroundColor(Color.White)
          .margin({ top: 30 })
        Image($r('app.media.ic_wechat_qrcode_logo'))
          .width(60)
          .height(60)
          .padding(6)
          .backgroundColor(Color.White)
          .margin({ right: 10 })
          .borderRadius(6)
      }

      Text("扫一扫上面的二维码图案，加我为好友")
        .fontColor(Color.Grey)
        .fontSize(15)
        .margin({ top: 20 })

      Blank().
      layoutWeight(1)
      Row() {
        Text("扫一扫")
          .fontColor(Color.Grey)
          .fontSize(16)
          .fontWeight(600)
          .fontColor("#5e658a")
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        Divider().vertical(true).color(Color.Grey)
          .height(10)

        Text("换个样式")
          .fontColor(Color.Grey)
          .fontSize(16)
          .fontWeight(600)
          .fontColor("#5e658a")
          .textAlign(TextAlign.Center)
          .layoutWeight(1)

        Divider().vertical(true).color(Color.Grey)
          .height(10)

        Text("保存图片")
          .fontColor(Color.Grey)
          .fontSize(16)
          .fontWeight(600)
          .fontColor("#5e658a")
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
      }
      .width(280)
      .margin({ bottom: 80 })
    }
    .width('100%')
  }
}