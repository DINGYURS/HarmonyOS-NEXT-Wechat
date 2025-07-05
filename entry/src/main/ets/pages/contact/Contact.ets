import router from '@ohos.router'
import ListContactItem from '../../component/ListContactItem'
import DataItem, { ContactItem } from './DataItem'
import WechatToolbar2 from '../../component/WechatToolbar2'

@Preview
@Component
export default struct Contact {
  private scroller: Scroller = new Scroller()
  private dataList: DataItem[] = [
    {
      title: '',
      contactList: [
        { name: "新的朋友", head: $r("app.media.ic_new_friend")},
        { name: "群聊", head: $r("app.media.ic_group_chat")},
        { name: "标签", head: $r("app.media.ic_tag")},
        { name: "公众号", head: $r("app.media.ic_official_account")}
      ]
    },
    {
      title: 'D',
      contactList: [
        { name: "町榆", head: $r("app.media.user_head_dy"), chatPage: 'pages/chat/ChatPage1' }
      ]
    },
    {
      title: 'H',
      contactList: [
        { name: "林依依", head: $r("app.media.user_head_lyy"), chatPage: 'pages/chat/ChatPage3' }
      ]
    },
    {
      title: 'M',
      contactList: [
        { name: "妹妹", head: $r("app.media.user_head_mm"), chatPage: 'pages/chat/ChatPage2' }
      ]
    },
    {
      title: 'W',
      contactList: [
        { name: "文件传输助手", head: $r("app.media.ic_user_files"), chatPage: 'pages/chat/ChatPage6'},
        { name: "王晓雨", head: $r("app.media.user_head_wxy"), chatPage: 'pages/chat/ChatPage5'}
      ]
    },
    {
      title: 'Z',
      contactList: [
        { name: "朱星兆", head: $r("app.media.user_head_zxz"), chatPage: 'pages/chat/ChatPage4'}
      ]
    }
  ];
  private letterList: string[] =
    ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
      'V', 'W', 'X', 'Y', 'Z', '#']

  @Builder
  itemHead(title: string) {
    Text(title)
      .fontSize(14)
      .visibility("" === title ? Visibility.None : Visibility.Visible)
      .backgroundColor("#EDEDED")
      .height(36)
      .width("100%")
      .padding({ left: 20 })
  }

  @State isMenuVisible: boolean = false;

  build() {
    Stack({ alignContent: Alignment.End }) {

      Column() {
        // 标题栏

        WechatToolbar2({ title: "通讯录" })
        // 通讯录列表
        List({ scroller: this.scroller }) {
          // 遍历循环大组标签
          ForEach(this.dataList, (item: DataItem) => {
            // 大组标签
            ListItemGroup({ header: this.itemHead(item.title) }) {
              // 遍历循环大组内的联系人列表
              ForEach(item.contactList, (contact: ContactItem) => {
                // // 小组联系人列表
                ListItem() {
                  ListContactItem({ head: contact.head, name: contact.name, chatPage: contact.chatPage})
                }
                .onClick(() => {
                  router.pushUrl({
                    url: 'pages/chat/ChatPage',
                    params: { name: contact.name }
                  })
                })
              })
            }
            .divider({
              strokeWidth: 0.8,
              color: '#f0f0f0',
              startMargin: 85,
              endMargin: 0
            })
          })
        }
        .width('100%')
        .height(0)
        .layoutWeight(1)
        .backgroundColor(Color.White)
      }
      .width("100%")
      .height("100%")

      AlphabetIndexer({ arrayValue: this.letterList, selected: 0 })
        .color(Color.Black)
        .font({ size: 14 })
        .selectedFont({ size: 14 })
        .selectedColor(Color.Black)
        .selectedBackgroundColor('#1dac60')
        .itemSize(20)
        .margin({ top: 80 })
        .onSelect((index: number) => {
          let letter = this.letterList[index]
          let target: number = 0
          for (const item of this.dataList) {
            if (letter === item.title) {
              this.scroller.scrollToIndex(target)
              break
            }
            target++
          }
        })

    }
    .width("100%")
    .height("100%")
  }
}
