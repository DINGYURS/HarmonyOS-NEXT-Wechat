import router from '@ohos.router'
import Toolbar from '../../component/Toolbar'

@Entry
@Component
struct MyPicture {
  build() {
    Column() {
      Toolbar({ title: "个人头像" })

      Row() {
        Image($r('app.media.myPic'))
          .objectFit(ImageFit.Contain)
          .width('100%')
      }
      .alignItems(VerticalAlign.Center)
      .flexGrow(1)
    }
    .height('100%')
    .width('100%')
  }
}