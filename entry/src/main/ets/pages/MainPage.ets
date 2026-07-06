import { NavigationService, Page } from '../services/NavigationService';
import { FocusListViewModel } from '../viewmodels/FocusListViewModel';
import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute } from '@kit.ArkUI';
import { LengthMetrics } from '@kit.ArkUI';

enum MainId {
  Button1 = 'mainBtn1',
  Button2 = 'mainBtn2',
  FocusTarget = 'focusTargetBtn',
  Jump = 'jumpBtn',
  Clear = 'clearBtn',
  Next = 'mainNextBtn'
}

@Component
export struct MainPage {
  private navigationService: NavigationService = NavigationService.getInstance();
  private vm: FocusListViewModel = new FocusListViewModel(
    [MainId.Button1, MainId.Button2, MainId.FocusTarget, MainId.Jump, MainId.Clear, MainId.Next]
  );

  aboutToAppear(): void { this.vm.activate(this.getUIContext()); }
  aboutToDisappear(): void { this.vm.deactivate(this.getUIContext()); }

  private bgColor(id: string, base: ResourceColor): ResourceColor {
    return this.vm.focusedId === id ? $r('app.color.white') : base;
  }
  private fgColor(id: string): ResourceColor {
    return this.vm.focusedId === id ? $r('app.color.black') : $r('app.color.white');
  }

  build() {
    Column() {
      Text($r('app.string.main_title'))
        .fontSize(14)
        .fontColor($r('app.color.white'))
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })

      Text($r('app.string.main_subtitle'))
        .fontSize(10)
        .fontColor($r('app.color.subtitle'))
        .margin({ top: 6 })

      ArcList({ initialIndex: 0 }) {
        ArcListItem() {
          Button($r('app.string.main_btn1'), { type: ButtonType.Capsule })
            .id(MainId.Button1)
            .width('78%')
            .height(46)
            .fontSize(13)
            .fontColor(this.fgColor(MainId.Button1))
            .backgroundColor(this.bgColor(MainId.Button1, $r('app.color.btn_blue')))
            .focusable(true)
            .defaultFocus(true)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.main_btn2'), { type: ButtonType.Capsule })
            .id(MainId.Button2)
            .width('78%')
            .height(46)
            .fontSize(13)
            .fontColor(this.fgColor(MainId.Button2))
            .backgroundColor(this.bgColor(MainId.Button2, $r('app.color.btn_green')))
            .focusable(true)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.main_focus_target'), { type: ButtonType.Capsule })
            .id(MainId.FocusTarget)
            .width('78%')
            .height(46)
            .fontSize(13)
            .fontColor(this.fgColor(MainId.FocusTarget))
            .backgroundColor(this.bgColor(MainId.FocusTarget, $r('app.color.btn_red')))
            .focusable(true)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.main_jump'), { type: ButtonType.Capsule })
            .id(MainId.Jump)
            .width('78%')
            .height(46)
            .fontSize(12)
            .fontColor(this.fgColor(MainId.Jump))
            .backgroundColor(this.bgColor(MainId.Jump, $r('app.color.btn_gray')))
            .focusable(true)
            .onClick(() => {
              const err: string = this.vm.jumpTo(this.getUIContext(), MainId.FocusTarget);
              if (err !== '') {
                this.getUIContext().getPromptAction().showToast({ message: err });
              }
            })
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.main_clear'), { type: ButtonType.Capsule })
            .id(MainId.Clear)
            .width('78%')
            .height(46)
            .fontSize(12)
            .fontColor(this.fgColor(MainId.Clear))
            .backgroundColor(this.bgColor(MainId.Clear, $r('app.color.btn_gray')))
            .focusable(true)
            .onClick(() => { this.vm.clearAndReset(this.getUIContext()); })
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.main_next'), { type: ButtonType.Capsule })
            .id(MainId.Next)
            .width('78%')
            .height(46)
            .fontSize(12)
            .fontColor(this.fgColor(MainId.Next))
            .backgroundColor(this.bgColor(MainId.Next, $r('app.color.btn_next')))
            .focusable(true)
            .onClick(() => { this.navigationService.navigateTo(Page.FOCUS_CONTROL_PAGE); })
        }
        .align(Alignment.Center)

      }
      .layoutWeight(1)
      .width('100%')
      .space(LengthMetrics.vp(8))
      .scrollBar(BarState.Off)
      .fadingEdge(true)
      .digitalCrownSensitivity(CrownSensitivity.MEDIUM)
      .focusable(true)
      .defaultFocus(true)
      .onScrollIndex((start: number, end: number, center: number) => {
        this.vm.onCenterChanged(this.getUIContext(), center);
      })
    }
    .width('100%')
    .height('100%')
  }
}
