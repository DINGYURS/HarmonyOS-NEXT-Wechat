import router from '@ohos.router'
import prompt from '@ohos.promptAction'
import WindowManager from '../utils/WindowManager'

@Component
export default struct WechatToolbar1 {

  build() {
    Row() {
      Row() {
        Image($r('app.media.ic_arrow_left'))
          .height(20)
          .width(20)
          .margin({ left: 16 }) // 设置左边距贴边
          .onClick(() => {
            router.back()
          })
      }
      .width('100%')
      .height(53)
      .alignItems(VerticalAlign.Center) // 垂直居中
    }
    .justifyContent(FlexAlign.Start) // Row 左对齐
    .backgroundColor("#FEFEFE")
    .padding({ top: WindowManager.statusBarHeight })
  }

}