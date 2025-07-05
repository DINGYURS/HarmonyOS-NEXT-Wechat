import { HashMap } from '@kit.ArkTS'
import { AppUtil, PreferencesUtil, ToastUtil } from '@pura/harmony-utils'
import WechatToolbar1 from '../../component/WechatToolbar1'

// index.ets
@Entry
@Component
struct Game2048 {
  @State grid: number[][] = Array(4).fill(0).map(() => Array(4).fill(0)) // 4x4游戏网格
  @State score: number = 0 // 当前得分
  @State bestScore: number = 0 // 历史最高分
  private startX: number = 0 // 触摸起始X坐标
  private startY: number = 0 // 触摸起始Y坐标

  // 生命周期方法：页面即将显示时触发
  aboutToAppear() {
    this.initGame()
    this.bestScore = PreferencesUtil.getNumberSync("bestScore") // 读取本地存储的最高分
  }

  // 初始化游戏
  initGame() {
    this.grid = this.grid.map(() => Array(4).fill(0)) // 重置网格
    this.addNewTile() // 添加两个新方块
    this.addNewTile() // 重置当前得分
    this.score = 0
  }

  addNewTile() {
    const emptyCells: [number, number][] = [] // 收集空单元格坐标
    this.grid.forEach((row, i) => {
      row.forEach((cell, j) => {
        if (cell === 0) {
          emptyCells.push([i, j])
        }
      })
    })

    if (emptyCells.length > 0) {
      let n = Math.floor(Math.random() * emptyCells.length) // 随机选择空单元格
      const i = emptyCells[n][0]
      const j = emptyCells[n][1]
      this.grid[i][j] = Math.random() < 0.9 ? 2 : 4 // 90%概率生成2，10%概率生成4
    }
  }

  // 处理移动逻辑
  move(direction: 'left' | 'right' | 'up' | 'down') {
    let newGrid = this.grid.map(row => [...row]) // 创建网格副本
    let moved = false // 移动标志位

    // 矩阵旋转辅助方法
    const rotate = (matrix: number[][]) => {
      return matrix[0].map((_, i) => matrix.map(row => row[i]).reverse())
    }
    const rotateReverse = (matrix: number[][]) => {
      return matrix[0].map((_, i) => matrix.map(row => row[row.length - 1 - i]))
    }

    // 处理单行移动和合并
    const moveRow = (row: number[]) => {
      let newRow = row.filter(cell => cell !== 0) // 移除空格
      for (let i = 0; i < newRow.length - 1; i++) {
        if (newRow[i] === newRow[i + 1]) { // 合并相同数字
          newRow[i] *= 2
          this.score += newRow[i] // 更新得分
          newRow.splice(i + 1, 1) // 移除合并后的元素
        }
      }

      // 补齐长度
      while (newRow.length < 4) {
        newRow.push(0)
      }
      return newRow
    }

    // 根据方向处理移动
    switch (direction) {
      case 'left':
        newGrid.forEach((row, i) => newGrid[i] = moveRow(row))
        break
      case 'right':
        newGrid.forEach((row, i) => newGrid[i] = moveRow(row.reverse()).reverse())
        break
      case 'up':
        let rotatedDown = rotate(newGrid)
        rotatedDown.forEach((row, i) => rotatedDown[i] = moveRow(row.reverse()).reverse())
        newGrid = rotateReverse(rotatedDown)
        break
      case 'down':
        let rotatedUp = rotate(newGrid)
        rotatedUp.forEach((row, i) => rotatedUp[i] = moveRow(row))
        newGrid = rotateReverse(rotatedUp)
        break
    }

    moved = JSON.stringify(newGrid) !== JSON.stringify(this.grid) // 判断是否发生移动
    this.grid = newGrid

    if (moved) {
      this.addNewTile() // 移动后添加新方块
      if (this.score > this.bestScore) { // 更新最高分
        this.bestScore = this.score
        PreferencesUtil.putSync('bestScore', this.bestScore) //保存最高分
      }
    }

    if (this.isGameOver()) { // 游戏结束检测
      ToastUtil.showToast('游戏结束！')
    }
  }

  // 游戏结束判断
  isGameOver(): boolean {
    // 检查空格子
    if (this.grid.some(row => row.includes(0))) {
      return false
    }

    // 检查横向可合并
    for (let i = 0; i < 4; i++) {
      for (let j = 0; j < 3; j++) {
        if (this.grid[i][j] === this.grid[i][j + 1]) {
          return false
        }
      }
    }

    // 检查纵向可合并
    for (let j = 0; j < 4; j++) {
      for (let i = 0; i < 3; i++) {
        if (this.grid[i][j] === this.grid[i + 1][j]) {
          return false
        }
      }
    }

    return true
  }

  build() {
    Column() {
      WechatToolbar1()
      // 分数显示行
      Row() {
        Text(`得分: ${this.score}`)
          .fontSize(20)
          .margin(10)
        Text(`最高分: ${this.bestScore}`)
          .fontSize(20)
          .margin(10)
        Button('新游戏')
          .onClick(() => this.initGame())
          .margin(10)
      }.margin({top:px2vp(AppUtil.getStatusBarHeight()) })

      // 游戏网格
      Grid() {
        ForEach(this.grid, (row: number[], i) => {
          ForEach(row, (value: number, j) => {
            GridItem() {
              Text(value ? `${value}` : '')
                .textAlign(TextAlign.Center)
                .fontSize(24)
                .fontColor(this.getTextColor(value))
                .width('100%')
                .height('100%')
                .backgroundColor(this.getTileColor(value))
                .animation({
                  duration: 150,
                  curve: Curve.EaseOut
                })
            }.key(`${i}-${j}`)
          })
        })
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')    // 4等分列
      .rowsTemplate('1fr 1fr 1fr 1fr')       // 4等分行
      .width('90%')
      .aspectRatio(1)                        // 保持正方形
      .margin(10)
      .onTouch((event) => {                  // 触摸事件处理
        if (event.type === TouchType.Down) {
          this.startX = event.touches[0].x
          this.startY = event.touches[0].y
        } else if (event.type === TouchType.Up) {
          const deltaX = event.touches[0].x - this.startX
          const deltaY = event.touches[0].y - this.startY

          // 根据滑动方向判断移动
          if (Math.abs(deltaX) > Math.abs(deltaY)) {
            deltaX > 0 ? this.move('right') : this.move('left')
          } else {
            deltaY > 0 ? this.move('down') : this.move('up')
          }
        }
      })
    }
    .width('100%')
  }

  // 获取方块背景色
  getTileColor(value: number): string {
    const colors = new HashMap<number, string>()
    colors.set(0, '#CDC1B4')
    colors.set(2, '#EEE4DA')
    colors.set(4, '#EDE0C8')
    colors.set(8, '#F2B179')
    colors.set(16, '#F59563')
    colors.set(32, '#F67C5F')
    colors.set(64, '#F65E3B')
    colors.set(128, '#EDCF72')
    colors.set(256, '#EDCF72')
    colors.set(512, '#EDCC61')
    colors.set(1024, '#EDC850')
    colors.set(2048, '#EDC22E')
    return colors.get(value) || '#CDC1B4'
  }

  // 获取文字颜色
  getTextColor(value: number): Color {
    return value > 4 ? Color.White : Color.Black
  }
}