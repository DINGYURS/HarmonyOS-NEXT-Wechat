import prompt from '@ohos.promptAction'

@Entry
@Component
export struct PlusMenu {
  build() {
      List() {
        // 发起群聊
        ListItem() {
          Row() {
            Image($r('app.media.ic_group'))
              .width(30)
              .height(30)
            Text('发起群聊')
              .fontSize(16)
              .fontColor('#333333') // 修改文字颜色为深灰色
              .margin({ left: 16 })
              .onClick(() => {
                prompt.showToast({ message: "功能尚未开发...", duration: 2000})
              })
          }
          .width('100%')
          .height(50)
          .borderRadius(4)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#f5f5f5') // 修改背景颜色为浅灰色
        }
        .backgroundColor('#f0f0f0') // 修改列表项背景颜色为更浅的灰色


        // 添加朋友
        ListItem() {
          Row() {
            Image($r('app.media.ic_add_friend'))
              .width(30)
              .height(30)
            Text('添加朋友')
              .fontSize(16)
              .fontColor('#333333') // 修改文字颜色为深灰色
              .margin({ left: 16 })
              .onClick(() => {
                prompt.showToast({ message: "功能尚未开发...", duration: 2000})
              })
          }
          .width('100%')
          .height(50)
          .borderRadius(4)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#f5f5f5') // 修改背景颜色为浅灰色
        }
        .backgroundColor('#f0f0f0') // 修改列表项背景颜色为更浅的灰色


        // 扫一扫
        ListItem() {
          Row() {
            Image($r('app.media.ic_scan'))
              .width(30)
              .height(30)
            Text('扫一扫')
              .fontSize(16)
              .fontColor('#333333') // 修改文字颜色为深灰色
              .margin({ left: 16 })
              .onClick(() => {
                prompt.showToast({ message: "功能尚未开发...", duration: 2000})
              })
          }
          .width('100%')
          .height(50)
          .borderRadius(4)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#f5f5f5') // 修改背景颜色为浅灰色
        }
        .backgroundColor('#f0f0f0') // 修改列表项背景颜色为更浅的灰色


        // 收付款
        ListItem() {
          Row() {
            Image($r('app.media.ic_charge'))
              .width(30)
              .height(30)
            Text('收付款')
              .fontSize(16)
              .fontColor('#333333') // 修改文字颜色为深灰色
              .margin({ left: 16 })
              .onClick(() => {
                prompt.showToast({ message: "功能尚未开发...", duration: 2000})
              })
          }
          .width('100%')
          .height(50)
          .borderRadius(4)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#f5f5f5') // 修改背景颜色为浅灰色
        }
        .backgroundColor('#f0f0f0') // 修改列表项背景颜色为更浅的灰色
      }
      .width('40%')
      .height('35%')
      .backgroundColor('#ffffff') // 修改整个列表的背景颜色为白色
      .borderRadius(8)

  }
}