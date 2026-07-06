import { NavigationService, Page } from '../services/NavigationService';
import { MainPage } from './MainPage';
import { FocusControlPage } from './FocusControlPage';
import { EventPage } from './EventPage';
import { AccessibilityPage } from './AccessibilityPage';
import GlobalContext from '../utils/GlobalContext';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  navigationService: NavigationService = NavigationService.getInstance();

  @Builder
  routeMap(name: string) {
    NavDestination() {
      if (name === Page.MAIN_PAGE) {
        MainPage()
      } else if (name === Page.FOCUS_CONTROL_PAGE) {
        FocusControlPage()
      } else if (name === Page.EVENT_PAGE) {
        EventPage()
      } else if (name === Page.ACCESSIBILITY_PAGE) {
        AccessibilityPage()
      }
    }
    .onBackPressed(() => {
      if (name === Page.MAIN_PAGE) {
        this.terminateApp();
        return true;
      }
      return false;
    })
    .hideTitleBar(true)
  }

  build() {
    Navigation(this.navigationService.pageInfos)
      .onAppear(() => {
        this.navigationService.navigateTo(Page.MAIN_PAGE);
      })
      .mode(NavigationMode.Stack)
      .navDestination(this.routeMap)
      .hideTitleBar(true)
      .width('100%')
      .height('100%')
      .backgroundColor($r('app.color.black'))
  }

  private terminateApp() {
    const context = GlobalContext.getInstance().getCntx() as common.UIAbilityContext;
    if (context) {
      context.terminateSelf()
    }
  }
}
