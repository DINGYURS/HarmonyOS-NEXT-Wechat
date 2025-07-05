import router from '@ohos.router'
import ListChatItem, { ChatItemData } from '../../component/ListChatItem'
import WechatToolbar from '../../component/WechatToolbar'
import { PlusMenu } from '../../component/PlusMenu'
import { SecondFloorLoadAnimationComponent } from './SecondFloorLoadAnimation';

@Preview
@Component
export default struct Home {
  @State chatList: ChatItemData[] = [
    {
    headSrc: $r("app.media.ic_user_lzy"),
    nickname: "刘智勇",
    content: "小心点别又被陶老师抓到了",
    time: "17:21"
  },
    {
      headSrc: $r("app.media.ic_user_zml"),
      nickname: "朱明亮",
      content: "刚才还秒了道黑题",
      time: "15:38"
    },
    { headSrc: $r("app.media.ic_user_hry"),
      nickname: "韩荣宇",
      content: "[动画表情]",
      time: "14:12"
    },
    { headSrc: $r("app.media.ic_user_wcy"),
      nickname: "王朝永",
      content: "[动画表情]",
      time: "12:08"
    },
    { headSrc: $r("app.media.ic_user_wyl"),
      nickname: "吴悠律",
      content: "太感谢啦！",
      time: "昨天" },
    { headSrc: $r("app.media.ic_user_files"),
      nickname: "文件传输助手",
      content: "打印信息安全的PPT",
      time: "周一" }
  ]

  @State isMenuVisible: boolean = false; // 在 Home 中定义状态变量

  build() {
    Column() {
      // WechatToolbar({ title: "微信(5)", isMenuVisible: this.isMenuVisible})
      SecondFloorLoadAnimationComponent()

      // 显示/隐藏 PlusMenu
      // if (this.isMenuVisible) {
      //   PlusMenu()
      //     .position({ x: '55%', y: 50 }) // 调整位置到右上角
      //     .zIndex(999) // 确保菜单在其他内容之上
      // }
/*
      List() {
        ForEach(this.chatList, (item: ChatItemData, index: number) => {
          ListItem() {
            ListChatItem({ data: item })
          }
          .onClick(() => {
            const PageNumber = index + 1
            router.pushUrl(
              {
                url: `pages/chat/ChatPage${PageNumber}`,
                params: {
                  name: item.nickname,
                  headSrc: item.headSrc
                }
              }
            )
            // router.pushUrl(
            //   {
            //     url: 'pages/chat/ChatPage1',
            //     params: {name:item.nickname, headSrc:item.headSrc}
            //   }
            // )
          })
        })
        ListItem() {
          Divider().color('#0000').strokeWidth(0)
        }
      }
      .divider({ strokeWidth: 0.8, color: '#f0f0f0', startMargin: 90, endMargin: 0 }) // 每行之间的分界线
      .backgroundColor(Color.White)
      .width("100%")
      .height("100%")*/

    }
    .width("100%")
    .height("100%")
    .backgroundColor("#f0f0f0")
  }
}
