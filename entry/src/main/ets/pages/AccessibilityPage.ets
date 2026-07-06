import { AccessibilityViewModel } from '../viewmodels/AccessibilityViewModel';
import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute } from '@kit.ArkUI';
import { LengthMetrics } from '@kit.ArkUI';

@Component
export struct AccessibilityPage {
  private vm: AccessibilityViewModel = new AccessibilityViewModel();

  aboutToAppear(): void {
    this.vm.activate(this.getUIContext());
  }

  aboutToDisappear(): void {
    this.vm.deactivate(this.getUIContext());
  }

  build() {
    Column() {
      Text($r('app.string.acc_title'))
        .fontSize(14)
        .fontColor($r('app.color.white'))
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })
        .width('50%')
        .maxLines(3)

      Text($r('app.string.acc_subtitle'))
        .fontSize(10)
        .fontColor($r('app.color.subtitle'))
        .margin({ top: 6 })

      ArcList({ initialIndex: 0 }) {
        ArcListItem() {
          Column({ space: 6 }) {
            Text($r('app.string.acc_slider_label'))
              .fontSize(11)
              .fontColor($r('app.color.label'))

            Slider({
              value: this.vm.sliderValue,
              min: 0,
              max: 100,
              step: 5
            })
              .id('accSlider')
              .width('80%')
              .focusable(true)
              .defaultFocus(true)
              .blockColor($r('app.color.accent'))
              .selectedColor($r('app.color.accent_dark'))
              .onChange((value: number) => {
                this.vm.setSliderValue(value);
              })

            Text($r('app.string.acc_value', this.vm.sliderValue))
              .fontSize(11)
              .fontColor($r('app.color.on_green'))
          }
          .width('86%')
          .padding(10)
          .borderRadius(10)
          .backgroundColor($r('app.color.card_bg'))
        }
        .align(Alignment.Center)

        ArcListItem() {
          Column({ space: 8 }) {

            Text($r('app.string.acc_toggle_label'))
              .fontSize(11)
              .fontColor($r('app.color.label'))

            Row() {
              Text($r('app.string.acc_notifications'))
                .fontSize(13)
                .fontColor($r('app.color.label'))
                .layoutWeight(1)

              Toggle({ type: ToggleType.Switch, isOn: this.vm.isOn })
                .id('accToggle')
                .width(44)
                .height(26)
                .focusable(true)
                .onChange((on: boolean) => {
                  this.vm.setOn(on);
                })
                .onAccessibilityFocus((isFocus: boolean) => {
                  this.vm.setAccessibilityFocus(isFocus);
                })
                .onAccessibilityActionIntercept((action: AccessibilityAction): AccessibilityActionInterceptResult => {
                  if (action === AccessibilityAction.ACCESSIBILITY_CLICK) {
                    this.vm.markIntercepted();
                    this.getUIContext().showAlertDialog({
                      title: $r('app.string.acc_confirm_title'),
                      message: $r('app.string.acc_confirm_msg', this.vm.isOn ? 'off' : 'on'),
                      primaryButton: {
                        value: $r('app.string.btn_ok'), action: () => {
                          this.vm.toggle();
                        }
                      },
                      secondaryButton: {
                        value: $r('app.string.btn_cancel'), action: () => {
                        }
                      }
                    });
                    return AccessibilityActionInterceptResult.ACTION_INTERCEPT;
                  }
                  return AccessibilityActionInterceptResult.ACTION_CONTINUE;
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }
          .width('86%')
          .padding(12)
          .borderRadius(10)
          .borderWidth(this.vm.hasFocus ? 2 : 1)
          .borderColor(this.vm.hasFocus ? $r('app.color.accent') : $r('app.color.btn_gray'))
          .backgroundColor($r('app.color.card_bg'))
        }
        .align(Alignment.Center)

        ArcListItem() {
          Column({ space: 6 }) {
            Text($r('app.string.acc_focus_state', this.vm.hasFocus ? 'true' : 'false'))
              .fontSize(11)
              .fontColor(this.vm.hasFocus ? $r('app.color.accent') : $r('app.color.subtitle'))

            Text($r('app.string.acc_last_intercept', this.vm.lastAction))
              .fontSize(11)
              .fontColor($r('app.color.label'))

            Text($r('app.string.acc_toggle_state', this.vm.isOn ? 'ON' : 'OFF'))
              .fontSize(12)
              .fontColor(this.vm.isOn ? $r('app.color.on_green') : $r('app.color.off_red'))

            Text($r('app.string.acc_warning'))
              .fontSize(10)
              .fontColor($r('app.color.subtitle'))
              .textAlign(TextAlign.Center)
              .padding(8)
              .borderWidth(1)
              .borderColor($r('app.color.border_dim'))
              .borderRadius(8)
          }
          .width('86%')
          .alignItems(HorizontalAlign.Center)

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
