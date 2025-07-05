import router from '@ohos.router';

@Component
@Entry
export default struct RegisterPage {
  @State username: string = ''
  @State telephone: string = ''
  @State password: string = ''
  @State confirmPassword: string = ''
  @State isLoading: boolean = false
  @State isChecked: boolean = false

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
      .margin({ top: 40 , bottom: 30})

      Text('手机号注册')
        .fontSize(25)
        .fontColor(Color.Black)
        .margin({ bottom: 30 })

      Column({ space: 25 }) {
        Row() {
          Text('昵称')
            .width('30%')
            .textAlign(TextAlign.Start)
          TextInput({
            placeholder: '例如：陈晨'
          })
            .width('60%')
            .borderRadius(10)
            .onChange((value: string) => {
              this.username = value;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('国家/地区')
            .width('30%')
            .textAlign(TextAlign.Start)
          Text('中国大陆（+86）')
            .fontColor('#777777')
            .width('60%')
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('手机号')
            .width('30%')
            .textAlign(TextAlign.Start)
          TextInput({
            placeholder: '请填写手机号'
          })
            .onChange((value: string) => {
              this.telephone = value;
            })
            .borderRadius(10)
            .width('60%')

        }
        .width('100%')
        .justifyContent(FlexAlign.Center)

        Row() {
          Text('密码')
            .width('30%')
            .textAlign(TextAlign.Start)
          TextInput({
            placeholder: '请输入密码'
          })
            .onChange((value: string) => {
              this.password = value;
            })
            .borderRadius(10)
            .width('60%')
        }

        Row() {
          Text('确认密码')
            .width('30%')
            .textAlign(TextAlign.Start)
          TextInput({
            placeholder: '请确认密码'
          })
            .onChange((value: string) => {
              this.confirmPassword = value;
            })
            .borderRadius(10)
            .width('60%')
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
      .margin({ top: 30 })
      .justifyContent(FlexAlign.Center)

      Blank()

      Column() {
        Row() {
          Checkbox()
            .onChange((value: boolean) => {
              this.isChecked = value
            })
          Text('我已阅读并同意')
            .fontSize(12)
            .fontColor('#a5a5a5')
          Text('《软件许可及服务协议》')
            .fontSize(12)
            .fontColor('#5a6a8f')
        }

        Row() {
          Text('本页面收集的信息仅用于注册账号')
            .fontSize(12)
            .fontColor('#a5a5a5')
        }
      }
      .margin({ bottom: 20 })


      Button() {
        Text('注册')
          .fontColor('#f5fffb')
          .fontSize(18)
      }
      .width(180)
      .height(50)
      .margin({ bottom: 50 })
      .borderRadius(10)
      .enabled(!this.isLoading)
      .backgroundColor('#0cc160')
      .onClick(() => {
        if (!this.isChecked) {
          AlertDialog.show({
            title: '注册失败',
            message: '请阅读《软件许可及服务协议》！',
            confirm: {
              value: '确定',
              action: () => {
                console.log('用户点击确定');
              }
            },
          });
          return;
        }

        if (this.username === '' || this.telephone === '' || this.password === ''
          || this.confirmPassword === '') {
          AlertDialog.show({
            title: '登录失败',
            message: '所有字段都必须填写！',
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
          if (this.password !== this.confirmPassword) {
            AlertDialog.show({
              title: '注册失败',
              message: '两次密码输入不一致！',
              confirm: {
                value: '确定',
                action: () => {
                  console.log('用户点击确定');
                }
              },
            });
          } else {
            router.pushUrl({ url: 'pages/login/LoginPage' });
          }
          this.isLoading = false
        }, 2000)
      })
    }
    .height('100%')
    .width('100%')
    .padding(20)
  }
}