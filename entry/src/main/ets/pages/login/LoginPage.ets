import { router } from "@kit.ArkUI"

@Entry
@Component
export default struct LoginPage {
  @State username: string = ''
  @State password: string = ''
  @State isLoading: boolean = false

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_cancel'))
          .width(20)
          .onClick(() => {
            router.pushUrl({ url: 'pages/login/FirstPage' })
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 20})

      Text('手机号登录')
        .fontSize(25)
        .fontColor(Color.Black)
        .margin({ bottom: 30})

      Column({ space: 25}) {
        Row() {
          Text('国家/地区')
            .width('25%')
            .textAlign(TextAlign.Center)
          Text('中国大陆（+86）')
            .fontColor('#0cc161')
            .width('60%')
            .margin({ left: 10})
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('手机号')
            .width('25%')
            .textAlign(TextAlign.Center)
          TextInput({
            placeholder: '请填写手机号'
          })
            .onChange((value: string) => {
              this.username = value;
            })
            .borderRadius(10)
            .width('60%')
            .margin({ left: 10})
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('密码')
            .width('25%')
            .textAlign(TextAlign.Center)
          TextInput({
            placeholder: '请输入密码'
          })
            .onChange((value: string) => {
              this.password = value;
            })
            .borderRadius(10)
            .width('60%')
            .margin({ left: 10})
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
      }

      Row() {
        if (this.isLoading) {
          LoadingProgress()
            .color('#a5a5a5')
            .width(30)
            .height(30);
        }
      }
      .width('100%')
      .height(30)
      .margin({ top: 30, bottom: 20})
      .justifyContent(FlexAlign.Center)

      Text('上述手机号仅用于登录验证')
        .margin({ bottom: 20})
        .fontSize(12)
        .fontColor('#a5a5a5')

      Button() {
        Text('登录')
          .fontColor('#f5fffb')
          .fontSize(18)
      }
      .width(180)
      .height(50)
      .borderRadius(10)
      .margin({ bottom: 20})
      .enabled(!this.isLoading)
      .backgroundColor('#0cc160')
      .onClick(() => {
        if (this.username === '' || this.password === '') {
          AlertDialog.show({
            title: '登录失败',
            message: '用户名或密码不能为空！',
            confirm: {
              value: '确定',
              action: () => {
                console.log('用户点击确定');
              }
            },
          });
          return;
        }

        this.isLoading = true;

        setTimeout(() => {
          if (this.username === '123456' && this.password === '123456') {
            router.pushUrl({ url: 'pages/Index' });
          } else {
            AlertDialog.show({
              title: '登录失败',
              message: '用户名或密码错误！',
              confirm: {
                value: '确定',
                action: () => {
                  console.log('用户点击确定');
                }
              },
            });
          }
          this.isLoading = false
        }, 2000)
      })

      Blank()

      Row() {
        Text('找回密码')
          .fontSize(12)
          .fontColor('#586b8f')
        Text('  |  ')
          .fontSize(12)
          .fontColor('#d9d9d9')
        Text('更多选项')
          .fontSize(12)
          .fontColor('#586b8f')
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .margin({ bottom: 20})
    }
    .height('100%')
    .width('100%')
    .padding(20)
  }
}