import router from '@ohos.router'
import prompt from '@ohos.promptAction'
import WindowManager from '../utils/WindowManager'

@Component
export default struct WechatToolbar {
  private title: string = "发现"

  build() {
    Column() {
      Stack() {
        Text(this.title)
          .fontColor(Color.Black)
          .fontSize(19)
          .fontWeight(500)

        Row() {
          Image($r("app.media.ic_search"))
            .width(22)
            .height(22)
            .margin({ right: 20 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/search/SearchPage' })
            })
        }
        .height("100%")
        .width("100%")
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.End)

      }
      .width("100%")
      .height(53)
    }.backgroundColor("#f0f0f0")
    .padding({ top: WindowManager.statusBarHeight })
  }
}