import { UIContext } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

export class FocusNavigatorUtil {

  static requestFocus(context: UIContext, id: string): string {
    try {
      context.getFocusController().requestFocus(id);
      return '';
    } catch (e) {
      const err = e as BusinessError;
      console.error(`requestFocus failed code:${err.code} msg:${err.message}`);
      return FocusNavigatorUtil.describe(err.code, id);
    }
  }

  static clearFocus(context: UIContext): void {
    try {
      context.getFocusController().clearFocus();
    } catch (e) {
      const err = e as BusinessError;
      console.error(`clearFocus failed code:${err.code} msg:${err.message}`);
    }
  }

  private static describe(code: number, id: string): string {
    switch (code) {
      case 150001:
        return `Cannot focus '${id}' (150001)`;
      case 150002:
        return `'${id}' has an unfocusable ancestor (150002)`;
      case 150003:
        return `'${id}' is not on tree (150003)`;
      default:
        return `requestFocus error (${code})`;
    }
  }
}
