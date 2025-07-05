import http from '@ohos.net.http'
import common from '@ohos.app.ability.common'
import WechatToolbar1 from '../../component/WechatToolbar1'
import { promptAction } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'


// ✅ 定义数据接口类型
interface CalendarData {
  code: number
  ynian: string
  yyue: string
  yri: string
  nyue: string
  nri: string
  ganzhinian: string
  ganzhiyue: string
  ganzhiri: string
  xingqi: string
  yi: string
  ji: string
  jieri: string
  shengxiao: string
  xingzuo: string
  xiangchong: string
  jijie: string
  nianwuxing: string
  yuewuxing: string
  riwuxing: string
  xingxiu: string
  liuyao: string
  shiershen: string
  rulueri: string
  yisilan: string
  pengzu: string
  taishen: string
  jieqi: string
  jieqimsg: string
}

interface HistoryTodayData {
  code: number
  msg?: string
  title?: string
  y?: string
  m?: string
  d?: string
  words?: string
  url?: string
}

@Entry
@Component
struct PerpetualCalendar {
  @State calendarData: CalendarData = {
    code: 0,
    ynian: '',
    yyue: '',
    yri: '',
    nyue: '',
    nri: '',
    ganzhinian: '',
    ganzhiyue: '',
    ganzhiri: '',
    xingqi: '',
    yi: '',
    ji: '',
    jieri: '',
    shengxiao: '',
    xingzuo: '',
    xiangchong: '',
    jijie: '',
    nianwuxing: '',
    yuewuxing: '',
    riwuxing: '',
    xingxiu: '',
    liuyao: '',
    shiershen: '',
    rulueri: '',
    yisilan: '',
    pengzu: '',
    taishen: '',
    jieqi: '',
    jieqimsg: ''
  }
  @State historyData: HistoryTodayData = { code: 0 }
  @State loading: boolean = true
  @State error: string = ''


  aboutToAppear() {
    this.fetchCalendarData()
    this.fetchHistoryToday()
  }

  fetchCalendarData() {
    const request = http.createHttp()
    request.request(
      'https://cn.apihz.cn/api/time/getday.php?id=10005781&key=2649ea6805ab7678853a24579e1d0778', // api地址
      {
        method: http.RequestMethod.GET,
        header: {
          'Content-Type': 'application/json'
        }
      },
      (err, data) => {
        if (err) {
          this.error = '请求失败：' + JSON.stringify(err)
          this.loading = false
          return
        }

        try {
          const json = JSON.parse(data.result as string) as CalendarData
          if (json.code === 200) {
            this.calendarData = json
          } else {
            this.error = '数据异常，状态码：' + json.code
          }
        } catch (e) {
          this.error = '解析失败'
        } finally {
          this.loading = false
        }
      }
    )
  }

  fetchHistoryToday() {
    const request = http.createHttp()
    request.request(
      'https://cn.apihz.cn/api/zici/today.php?id=10005781&key=2649ea6805ab7678853a24579e1d0778', // api地址
      {
        method: http.RequestMethod.GET,
        header: { 'Content-Type': 'application/json' }
      },
      (err, data) => {
        if (!err) {
          try {
            const json = JSON.parse(data.result as string) as HistoryTodayData
            if (json.code === 200) {
              this.historyData = json
            }
          } catch (_) {
            console.log('历史数据解析失败')
          }
        }
      }
    )
  }

  build() {
    Column() {
      if (this.loading) {
        Text('正在加载...')
          .fontSize(20)
          .padding(20)
      } else if (this.error !== '') {
        Text('错误：' + this.error)
          .fontSize(18)
          .fontColor(Color.Red)
          .padding(20)
      } else {
        WechatToolbar1()
        Scroll() {
          Column(){
            // 黄历
            Row() {
              Text('黄历')
                .fontSize(18)
                .fontWeight(FontWeight.Normal)
                .layoutWeight(1)
                .fontColor('#5B5F62')

              Button('订阅')
                .fontSize(12)
                .width(80)
                .backgroundColor('#F65F42')
                .borderRadius(40)
            }
            .padding({left:20, right:20})

            Column(){
              // 顶部
              Row(){
                Text(`${this.calendarData.ynian}年 ${this.calendarData.yyue}月${this.calendarData.yri}日  ${this.calendarData.xingqi}`)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .layoutWeight(1)

                Text('农历')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E4684B')
                  .width(40)
                  .padding(5)
                  .borderRadius(14)
                  .backgroundColor('#FCF1ED')
              }
              .margin({bottom:5})

              // 中部
              Row(){
                Text(`${this.calendarData.nyue}${this.calendarData.nri}`)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bolder)
                  .fontColor('#F0623B')
                  .layoutWeight(1)

                Column(){
                  Text(`${this.calendarData.ganzhiyue} ${this.calendarData.ganzhiri}`)
                    .fontSize(12)
                    .fontColor('#666')

                  Text(`${this.calendarData.ganzhinian}[${this.calendarData.shengxiao}]`)
                    .fontSize(12)
                    .fontColor('#666')
                }
                .alignItems(HorizontalAlign.End)
              }
              .margin({bottom: 40})

              // 底部
              Row(){
                Column() {
                  // 宜
                  Row() {
                    Stack() {
                      Circle()
                        .width(24)
                        .height(24)
                        .colorBlend('#F65F42')

                      Text('宜')
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#FFFFFF')
                        .align(Alignment.Center)
                    }
                    .margin({ right: 5 })

                    Text(this.calendarData.yi.split('|').slice(0, 5).join(' '))
                      .fontSize(12)
                      .fontColor('#E4684B')
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .maxLines(1)
                  }

                  .width('100%')
                  .margin({ bottom: 5 })

                  // 忌
                  Row() {
                    Stack() {
                      Circle()
                        .width(24)
                        .height(24)
                        .colorBlend('#666666')

                      Text('忌')
                        .fontSize(12)
                        .fontWeight(FontWeight.Medium)
                        .fontColor('#FFFFFF')
                        .align(Alignment.Center)
                    }
                    .margin({ right: 5 })

                    Text(this.calendarData.ji.split('|').slice(0, 5).join(' '))
                      .fontSize(12)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                      .maxLines(1)
                  }
                  .width('100%')
                }
              }
              .width('100%') // 让 Column 占满横向空间，从而内容更贴左
            }
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(18)
            .shadow({ radius: 10, color: '#999999', offsetX: 0, offsetY: 6 }) // 卡片阴影
            .margin({ top: 10, bottom: 20, left: 12, right: 12 })


            // 历史上的今天
            Row() {
              Text('历史上的今天')
                .fontSize(18)
                .fontWeight(FontWeight.Normal)
                .layoutWeight(1)
                .fontColor('#5B5F62')

              Button('订阅')
                .fontSize(12)
                .width(80)
                .backgroundColor('#F65F42')
                .borderRadius(40)
            }
            .padding({left:20, right:20})

            Column() {
              // 上部
              Row() {
                Text(`${this.calendarData.ynian}年 ${this.calendarData.yyue}月${this.calendarData.yri}日  ${this.calendarData.xingqi}`)
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
                  .layoutWeight(1)

                Text('历史上的今天')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#E4684B')
                  .width(90)
                  .padding(5)
                  .borderRadius(214)
                  .backgroundColor('#FCF1ED')
                  .textAlign(TextAlign.Center)
              }
              .margin({ bottom: 20 })

              // 下部内容
              Row() {
                Image($r('app.media.gugong'))
                  .width(100)
                  .height(100)
                  .borderRadius(50)
                  .margin({ right: 12 })

                Text(this.historyData.title ?? '暂无事件')
                  .fontSize(18)
                  .fontColor('#F0623B')
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
                  .layoutWeight(1)
              }
              .width('100%')

              // 跳转按钮
              if (this.historyData.url) {
                Row() {
                  Blank() // 占位让按钮靠右
                    .layoutWeight(1)

                  Text('🔎 查看详情')
                    .fontSize(12)
                    .fontColor('#007AFF')
                    .onClick(() => {
                      try {
                        const context = getContext(this) as common.UIAbilityContext
                        context.openLink(this.historyData.url, { appLinkingOnly: false })
                          .then(() => {
                            console.info('跳转浏览器成功');
                          })
                          .catch((err: BusinessError) => {
                            promptAction.showToast({ message: `跳转失败: ${err.message}` });
                            console.error('跳转浏览器失败:', JSON.stringify(err));
                          });
                      } catch (err) {
                        promptAction.showToast({ message: `异常: ${JSON.stringify(err)}` });
                        console.error('跳转异常:', JSON.stringify(err));
                      }
                    })
                }
                .width('100%')
                .alignItems(VerticalAlign.Center)
              }
            }
            .padding(12)
            .backgroundColor(Color.White)
            .borderRadius(18)
            .shadow({ radius: 10, color: '#999999', offsetX: 0, offsetY: 6 }) // 卡片阴影
            .margin({ top: 10, bottom: 20, left: 12, right: 12 })
          }
          .width('90%')
        }
      }
    }
    .backgroundColor('#fefefe')
    .width('100%')
    .height('100%')
  }
}
