import { NavigationService, Page } from '../services/NavigationService';
import { FocusListViewModel } from '../viewmodels/FocusListViewModel';
import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute } from '@kit.ArkUI';
import { ColorMetrics, LengthMetrics } from '@kit.ArkUI';

enum FocusControlId {
  Button1 = 'fcBtn1',
  Button2 = 'fcBtn2',
  Disabled = 'fcBtnDisabled',
  Button3 = 'fcBtn3',
  Next = 'fcNextBtn'
}

@Component
export struct FocusControlPage {
  private navigationService: NavigationService = NavigationService.getInstance();
  private vm: FocusListViewModel = new FocusListViewModel(
    [FocusControlId.Button1, FocusControlId.Button2, FocusControlId.Disabled, FocusControlId.Button3,
      FocusControlId.Next]
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

  private focusBoxStyle(): FocusBoxStyle {
    return {
      strokeColor: ColorMetrics.resourceColor($r('app.color.accent')),
      strokeWidth: LengthMetrics.vp(2)
    };
  }

  build() {
    Column() {
      Text($r('app.string.fc_title'))
        .fontSize(14)
        .fontColor($r('app.color.white'))
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })

      Text($r('app.string.fc_subtitle'))
        .fontSize(9)
        .fontColor($r('app.color.subtitle'))
        .margin({ top: 6 })

      ArcList({ initialIndex: 0 }) {
        ArcListItem() {
          Button($r('app.string.fc_btn1'), { type: ButtonType.Capsule })
            .id(FocusControlId.Button1)
            .width('80%')
            .height(46)
            .fontSize(12)
            .fontColor(this.fgColor(FocusControlId.Button1))
            .backgroundColor(this.bgColor(FocusControlId.Button1, $r('app.color.btn_blue')))
            .focusable(true)
            .defaultFocus(true)
            .focusOnTouch(true)
            .focusBox(this.focusBoxStyle())
            .tabIndex(1)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.fc_btn2'), { type: ButtonType.Capsule })
            .id(FocusControlId.Button2)
            .width('80%')
            .height(46)
            .fontSize(12)
            .fontColor(this.fgColor(FocusControlId.Button2))
            .backgroundColor(this.bgColor(FocusControlId.Button2, $r('app.color.btn_blue')))
            .focusable(true)
            .focusOnTouch(true)
            .focusBox(this.focusBoxStyle())
            .tabIndex(2)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.fc_disabled'), { type: ButtonType.Capsule })
            .id(FocusControlId.Disabled)
            .width('80%')
            .height(46)
            .fontSize(12)
            .fontColor($r('app.color.disabled_text'))
            .backgroundColor($r('app.color.disabled_bg'))
            .focusable(false)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.fc_btn3'), { type: ButtonType.Capsule })
            .id(FocusControlId.Button3)
            .width('80%')
            .height(46)
            .fontSize(12)
            .fontColor(this.fgColor(FocusControlId.Button3))
            .backgroundColor(this.bgColor(FocusControlId.Button3, $r('app.color.btn_blue')))
            .focusable(true)
            .focusOnTouch(true)
            .focusBox(this.focusBoxStyle())
            .tabIndex(3)
        }
        .align(Alignment.Center)

        ArcListItem() {
          Button($r('app.string.fc_next'), { type: ButtonType.Capsule })
            .id(FocusControlId.Next)
            .width('80%')
            .height(46)
            .fontSize(12)
            .fontColor(this.fgColor(FocusControlId.Next))
            .backgroundColor(this.bgColor(FocusControlId.Next, $r('app.color.btn_next')))
            .focusable(true)
            .focusOnTouch(true)
            .focusBox(this.focusBoxStyle())
            .onClick(() => {
              this.navigationService.navigateTo(Page.EVENT_PAGE);
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
