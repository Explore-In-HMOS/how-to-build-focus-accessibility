import { UIContext } from '@kit.ArkUI';
import { FocusNavigatorUtil } from '../utils/FocusNavigatorUtil';

@ObservedV2
export class FocusListViewModel {
  @Trace focusedId: string = '';
  @Trace centerIndex: number = -1;

  private focusIds: string[] = [];

  constructor(focusIds: string[], initialFocusedId?: string) {
    this.focusIds = focusIds;
    this.focusedId = initialFocusedId ?? (focusIds.length > 0 ? focusIds[0] : '');
  }

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
    if (id === '') {
      this.focusedId = '';
      return;
    }
    const err: string = FocusNavigatorUtil.requestFocus(ctx, id);
    this.focusedId = err === '' ? id : '';
  }

  jumpTo(ctx: UIContext, id: string): string {
    const err: string = FocusNavigatorUtil.requestFocus(ctx, id);
    if (err === '') {
      this.focusedId = id;
    }
    return err;
  }

  clearAndReset(ctx: UIContext): void {
    FocusNavigatorUtil.clearFocus(ctx);
    this.focusedId = '';
    this.centerIndex = -1;
  }
}
