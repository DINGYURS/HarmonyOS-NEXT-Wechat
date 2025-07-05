import { promptAction } from '@kit.ArkUI'

// 使用装饰器来观察数据变化
@ObservedV2
class GameCell {
  @Trace value: string;
  @Trace isVisible: boolean = false;
  @Trace rotationAngle: number = 0;
  isFrontVisible: boolean = false;
  isMatched: boolean = false;
  isAnimationRunning: boolean = false;

  constructor(value: string) {
    this.value = value;
  }

  // 显示正面，参数为带动画时间
  revealFace(animationTime: number, callback?: () => void) {
    if (this.isAnimationRunning) {
      return;
    }
    this.isAnimationRunning = true;
    animateToImmediately({
      duration: animationTime,
      iterations: 1,
      curve: Curve.Linear,
      onFinish: () => {
        animateToImmediately({
          duration: animationTime,
          iterations: 1,
          curve: Curve.Linear,
          onFinish: () => {
            this.isFrontVisible = true;
            this.isAnimationRunning = false;
            if (callback) {
              callback();
            }
          }
        }, () => {
          this.isVisible = true;
          this.rotationAngle = 0;
        });
      }
    }, () => {
      this.isVisible = false;
      this.rotationAngle = 90;
    });
  }

  reset() {
    this.isVisible = false;
    this.rotationAngle = 180;
    this.isFrontVisible = false;
    this.isAnimationRunning = false;
    this.isMatched = false;
  }

  // 显示背面，参数为带动画时间
  hideFace(animationTime: number, callback?: () => void) {
    if (this.isAnimationRunning) {
      return;
    }
    this.isAnimationRunning = true;
    animateToImmediately({
      duration: animationTime,
      iterations: 1,
      curve: Curve.Linear,
      onFinish: () => {
        animateToImmediately({
          duration: animationTime,
          iterations: 1,
          curve: Curve.Linear,
          onFinish: () => {
            this.isFrontVisible = false;
            this.isAnimationRunning = false;
            if (callback) {
              callback();
            }
          }
        }, () => {
          this.isVisible = false;
          this.rotationAngle = 180;
        });
      }
    }, () => {
      this.isVisible = true;
      this.rotationAngle = 90;
    });
  }
}

// 定义组件入口
@Entry
@Component
struct MemoryGame {
  @State gameCells: GameCell[] = [];
  @State cellSize: number = 150; // 单元格大小
  @State cellSpacing: number = 5; // 单元格之间的间距
  @State transitionDuration: number = 150; // 过渡动画持续时间
  @State firstSelectedIndex: number | null = null; // 记录第一次选择的卡片索引
  @State secondSelectedIndex: number | null = null; // 记录第二次选择的卡片索引
  @State isGameOver: boolean = false; // 游戏是否结束
  @State startTime: number = 0; // 游戏开始时间

  aboutToAppear(): void {
    let cardValues: string[] = ["A", "B", "C", "D", "E", "F", "G", "H"];
    for (let value of cardValues) {
      this.gameCells.push(new GameCell(value));
      this.gameCells.push(new GameCell(value));
    }
    this.shuffleCards();
  }

  shuffleCards() {
    this.firstSelectedIndex = null;
    this.secondSelectedIndex = null;
    this.isGameOver = false;
    this.startTime = Date.now();

    for (let i = 0; i < 16; i++) {
      this.gameCells[i].reset();
    }

    for (let i = this.gameCells.length - 1; i > 0; i--) {
      const randomIndex = Math.floor(Math.random() * (i + 1));
      let tempValue = this.gameCells[i].value;
      this.gameCells[i].value = this.gameCells[randomIndex].value;
      this.gameCells[randomIndex].value = tempValue;
    }
  }

  checkForMatch() {
    if (this.firstSelectedIndex !== null && this.secondSelectedIndex !== null) {
      const firstCell = this.gameCells[this.firstSelectedIndex];
      const secondCell = this.gameCells[this.secondSelectedIndex];

      if (firstCell.value === secondCell.value) {
        firstCell.isMatched = true;
        secondCell.isMatched = true;
        this.firstSelectedIndex = null;
        this.secondSelectedIndex = null;

        if (this.gameCells.every(cell => cell.isMatched)) {
          this.isGameOver = true;
          console.info("游戏结束");
          promptAction.showDialog({
            title: '游戏胜利！',
            message: '恭喜你，用时：' + ((Date.now() - this.startTime) / 1000).toFixed(3) + '秒',
            buttons: [{ text: '重新开始', color: '#ffa500' }]
          }).then(() => {
            this.shuffleCards(); // 重新开始游戏
          });
        }
      } else {
        setTimeout(() => {
          if (this.firstSelectedIndex !== null) {
            this.gameCells[this.firstSelectedIndex].hideFace(this.transitionDuration, () => {
              this.firstSelectedIndex = null;
            });
          }
          if (this.secondSelectedIndex !== null) {
            this.gameCells[this.secondSelectedIndex].hideFace(this.transitionDuration, () => {
              this.secondSelectedIndex = null;
            });
          }
        }, 400);
      }
    }
  }

  build() {
    Column({ space: 20 }) {
      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(this.gameCells, (gameCell: GameCell, index: number) => {
          Text(`${gameCell.isVisible ? gameCell.value : ''}`)
            .width(`${this.cellSize}lpx`)
            .height(`${this.cellSize}lpx`)
            .margin(`${this.cellSpacing}lpx`)
            .fontSize(`${this.cellSize / 2}lpx`)
            .textAlign(TextAlign.Center)
            .backgroundColor(gameCell.isVisible ? Color.Orange : Color.Gray)
            .fontColor(Color.White)
            .borderRadius(5)
            .rotate({
              x: 0,
              y: 1,
              z: 0,
              angle: gameCell.rotationAngle,
              centerX: `${this.cellSize / 2}lpx`,
              centerY: `${this.cellSize / 2}lpx`,
            })
            .onClick(() => {
              if (this.isGameOver) {
                console.info("游戏已结束");
                return;
              }
              if (gameCell.isMatched) {
                console.info("当前已标记");
                return;
              }
              if (this.firstSelectedIndex == null) {
                this.firstSelectedIndex = index;
                if (!gameCell.isFrontVisible) {
                  gameCell.revealFace(this.transitionDuration);
                }
              } else if (this.firstSelectedIndex == index) {
                console.info("和上一次点击的是一样的，不予处理");
              } else if (this.secondSelectedIndex == null) {
                this.secondSelectedIndex = index;
                if (!gameCell.isFrontVisible) {
                  gameCell.revealFace(this.transitionDuration, () => {
                    this.checkForMatch();
                  });
                }
              }
            });
        });
      }.width(`${(this.cellSize + this.cellSpacing * 2) * 4}lpx`);
      Button('重新开始').onClick(() => {
        this.shuffleCards();
      });
    }.height('100%').width('100%');
  }
}
