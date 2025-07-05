import router from '@ohos.router';

@Component
@Entry
export default struct FirstPage {
  @State isButtonVisible: boolean = false;
  @State buttonOpacity: number = 0;

  build() {
    Column() {

      Blank()

      if (this.isButtonVisible) {
        Row() {
          //登录按钮
          Button() {
            Text('登录')
              .fontColor('#c9f5dd')
              .fontSize(18)
          }
          .onClick(() => {
            router.replaceUrl({
              url: 'pages/login/LoginPage'
            })
          })
          .width(120)
          .height(50)
          .padding(10)
          .borderRadius(5)
          .backgroundColor('#0cc160')

          //注册按钮
          Button() {
            Text('注册')
              .fontColor('#bbbbbb')
              .fontSize(18)
          }
          .onClick(() => {
            router.pushUrl({
              url: 'pages/register/RegisterPage'
            })
          })
          .width(120)
          .height(50)
          .padding(10)
          .borderRadius(5)
          .backgroundColor('#181818')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ bottom: 70 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.bgImage'))
    .backgroundImageSize(ImageSize.Cover)
    .onAppear(() => {
      setTimeout(() => {
       animateTo({
        duration:700,
         curve: Curve.EaseOut
       }, () => {
         this.isButtonVisible = true
         this.buttonOpacity = 1;
       });
      }, 2000);
    })
  }
}