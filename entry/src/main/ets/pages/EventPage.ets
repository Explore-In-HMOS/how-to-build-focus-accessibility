import { NavigationService, Page } from '../services/NavigationService';
import { FocusListViewModel } from '../viewmodels/FocusListViewModel';
import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute } from '@kit.ArkUI';
import { LengthMetrics } from '@kit.ArkUI';

enum EventId {
  Button1 = 'evtBtn1',
  Button2 = 'evtBtn2',
  Button3 = 'evtBtn3',
  Next = 'evtNextBtn'
}

@Component
export struct EventPage {
  private navigationService: NavigationService = NavigationService.getInstance();
  private vm: FocusListViewModel = new FocusListViewModel(
    [EventId.Button1, EventId.Button2, EventId.Button3, EventId.Next]
  );

  aboutToAppear(): void {
    this.vm.activate(this.getUIContext());
  }

  aboutToDisappear(): void {
    this.vm.deactivate(this.getUIContext());
  }

  private bgColor(id: string, base: ResourceColor): ResourceColor {
    return this.vm.focusedId === id ? $r('app.color.white') : base;
  }

  private fgColor(id: string): ResourceColor {
    return this.vm.focusedId === id ? $r('app.color.black') : $r('app.color.white');
  }

  build() {
    Column() {
      Text($r('app.string.evt_title'))
        .fontSize(14)
        .fontColor($r('app.color.white'))
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })

      Text($r('app.string.evt_subtitle'))
        .fontSize(9)
        .fontColor($r('app.color.subtitle'))
        .margin({ top: 6 })

      ArcList({ initialIndex: 0 }) {

        ArcListItem() {
          Button($r('app.string.evt_btn1'), { type: ButtonType.Capsule })
            .id(EventId.Button1)
            .width('80%')
            .height(46)
            .fontSize(13)
            .fontColor(this.fgColor(EventId.Button1))
            .backgroundColor(this.bgColor(EventId.Button1, $r('app.color.btn_blue')))
            .focusable(true)
            .defaultFocus(true)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.evt_btn2'), { type: ButtonType.Capsule })
            .id(EventId.Button2)
            .width('80%')
            .height(46)
            .fontSize(13)
            .fontColor(this.fgColor(EventId.Button2))
            .backgroundColor(this.bgColor(EventId.Button2, $r('app.color.btn_green')))
            .focusable(true)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.evt_btn3'), { type: ButtonType.Capsule })
            .id(EventId.Button3)
            .width('80%')
            .height(46)
            .fontSize(13)
            .fontColor(this.fgColor(EventId.Button3))
            .backgroundColor(this.bgColor(EventId.Button3, $r('app.color.btn_red')))
            .focusable(true)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.evt_next'), { type: ButtonType.Capsule })
            .id(EventId.Next)
            .width('80%')
            .height(46)
            .fontSize(12)
            .fontColor(this.fgColor(EventId.Next))
            .backgroundColor(this.bgColor(EventId.Next, $r('app.color.btn_next')))
            .focusable(true)
            .onClick(() => {
              this.navigationService.navigateTo(Page.ACCESSIBILITY_PAGE);
            })
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
