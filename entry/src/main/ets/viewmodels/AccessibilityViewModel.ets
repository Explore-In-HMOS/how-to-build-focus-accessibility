import { UIContext } from '@kit.ArkUI';
import { FocusNavigatorUtil } from '../utils/FocusNavigatorUtil';

@ObservedV2
export class AccessibilityViewModel {
  @Trace isOn: boolean = false;
  @Trace hasFocus: boolean = false;
  @Trace sliderValue: number = 30;
  @Trace lastAction: string = '-';
  @Trace centerIndex: number = -1;

  private focusIds: string[] = ['accSlider', 'accToggle', ''];

  activate(ctx: UIContext): void {
    ctx.getFocusController().activate(true, false);
  }

  deactivate(ctx: UIContext): void {
    ctx.getFocusController().activate(false);
  }

  onCenterChanged(ctx: UIContext, center: number): void {
    if (center < 0 || center >= this.focusIds.length || center === this.centerIndex) {
      return;
    }
    this.centerIndex = center;
    const id: string = this.focusIds[center];
    if (id !== '') {
      FocusNavigatorUtil.requestFocus(ctx, id);
    }
  }

  setSliderValue(value: number): void {
    this.sliderValue = value;
  }

  setAccessibilityFocus(isFocus: boolean): void {
    this.hasFocus = isFocus;
  }

  markIntercepted(): void {
    this.lastAction = 'click intercepted';
  }

  setOn(value: boolean): void {
    this.isOn = value;
  }

  toggle(): void {
    this.isOn = !this.isOn;
  }
}
