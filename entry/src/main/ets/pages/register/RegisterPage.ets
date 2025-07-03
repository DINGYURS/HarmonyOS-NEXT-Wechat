// entry/src/main/ets/pages/register/RegisterPage.ets
import router from '@ohos.router';

@Component
@Entry
export default struct RegisterPage {
  @State username: string = ''
  @State password: string = ''
  @State confirmPassword: string = ''

  build() {
    Column({ space: 20 }) {
      Text("用户注册")
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40 })

      // 用户名输入框
      Stack() {
        if (this.username === '') {
          Text("请输入用户名")
            .fontSize(14)
            .fontColor('#999')
            .position({ left: 10, top: 12 })
        }
        TextInput()
          .type(InputType.Normal)
          .onChange((value: string) => {
            this.username = value;
          })
          .width('90%')
          .height(45)
          .fontSize(14)
          .padding({ left: 10, right: 10 })
          .border({
            width: 1,
            color: '#ccc',
            radius: 8
          })
      }

      // 密码输入框
      Stack() {
        if (this.password === '') {
          Text("请输入密码")
            .fontSize(14)
            .fontColor('#999')
            .position({ left: 10, top: 12 })
        }
        TextInput()
          .type(InputType.Password)
          .onChange((value: string) => {
            this.password = value;
          })
          .width('90%')
          .height(45)
          .fontSize(14)
          .padding({ left: 10, right: 10 })
          .border({
            width: 1,
            color: '#ccc',
            radius: 8
          })
      }

      // 确认密码输入框
      Stack() {
        if (this.confirmPassword === '') {
          Text("请确认密码")
            .fontSize(14)
            .fontColor('#999')
            .position({ left: 10, top: 12 })
        }
        TextInput()
          .type(InputType.Password)
          .onChange((value: string) => {
            this.confirmPassword = value;
          })
          .width('90%')
          .height(45)
          .fontSize(14)
          .padding({ left: 10, right: 10 })
          .border({
            width: 1,
            color: '#ccc',
            radius: 8
          })
      }

      // 注册按钮
      Button("注册", { type: ButtonType.Normal })
        .width('90%')
        .height(45)
        .backgroundColor('#07C160')
        .fontColor('#FFFFFF')
        .borderRadius(6)
        .onClick(() => {
          if (!this.username || !this.password || !this.confirmPassword) {
            console.error('所有字段都必须填写');
            return;
          }

          if (this.password !== this.confirmPassword) {
            console.error('两次输入的密码不一致');
            return;
          }

          console.log('注册成功');
          router.back(); // 返回上一页（登录页）
        })

    }
    .width('100%')
    .height('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#f9f9f9')
  }
}