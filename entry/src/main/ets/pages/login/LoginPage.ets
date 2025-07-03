// LoginPage.ets（修复版）
import router from '@ohos.router';

@Component
@Entry
export default struct LoginPage {
  @State username: string = ''
  @State password: string = ''

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 背景图片层
      Image($r('app.media.bgImage'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .position({ x: 0, y: 0 })

      Column({ space: 30 }) {
        // 微信标题栏
        Column({ space: 5 }) {
          Text("微信号/QQ号/邮箱登录")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .fontFamily('Si yuan')
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
        .alignItems(HorizontalAlign.Center)

        // 输入容器
        Column({ space: 25 }) {
          // 用户名输入框
          Stack() {
            TextInput()
              .type(InputType.Normal)
              .onChange((value: string) => {
                this.username = value;
              })
              .width('90%')
              .height(50)
              .fontSize(17)
              .fontColor(Color.White) // 设置输入文字为白色
              .padding({ left: 15, right: 15 })
              .border({
                width: 0.8,
                color: '#444444',
                radius: 8
              })
              .backgroundColor('rgba(0,0,0,0.7)') // 统一为纯黑背景
              .margin({ top: 5 })

            if (this.username === '') {
              Text("微信号/手机号/邮箱")
                .fontSize(17)
                .fontColor(Color.White) // 浅灰占位符
                .textShadow({ radius: 2, color: Color.Black, offsetX: 1, offsetY: 1 })
                .position({ left: 15, top: 15 })
            }
          }

          // 密码输入框
          Stack() {
            TextInput()
              .type(InputType.Password)
              .onChange((value: string) => {
                this.password = value;
              })
              .width('90%')
              .height(50)
              .fontSize(17)
              .fontColor(Color.White) // 设置输入文字为白色
              .padding({ left: 15, right: 15 })
              .border({
                width: 0.8,
                color: '#444444', // 统一为深灰边框
                radius: 8
              })
              .backgroundColor('rgba(0,0,0,0.7)') // 统一为纯黑背景
              .margin({ top: 5 })

            if (this.password === '') {
              Text("密码")
                .fontSize(17)
                .fontColor(Color.White)
                .position({ left: 15, top: 15 })
            }
          }

          // 注册入口
          Row() {
            Text("更多登录方式")
              .fontSize(15)
              .fontColor('#00d7ff')
              .onClick(() => {
                router.pushUrl({ url: 'pages/register/RegisterPage' });
              })
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          .justifyContent(FlexAlign.Start)

          // 登录按钮
          Button("登录", { type: ButtonType.Normal })
            .width('90%')
            .height(50)
            .fontSize(18)
            .backgroundColor('#07C160')
            .fontColor('#FFFFFF')
            .borderRadius(6)
            .onClick(() => {
              if (this.username === '' || this.password === '') {
                console.error('用户名或密码不能为空！');
                return;
              }

              if (this.username === 'admin' && this.password === '123456') {
                router.pushUrl({ url: 'pages/Index' });
              } else {
                console.error('用户名或密码错误！');
              }
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
      }
      .width('100%')
      .height('100%')
      .padding({ top: 40 })
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Transparent)
    }
  }
}