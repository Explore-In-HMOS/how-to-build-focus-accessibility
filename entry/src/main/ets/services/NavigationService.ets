@ObservedV2
export class NavigationService {
  static _instance: NavigationService;

  @Trace pageInfos: NavPathStack = new NavPathStack();

  static getInstance(): NavigationService {
    if (!NavigationService._instance) {
      NavigationService._instance = new NavigationService();
    }
    return NavigationService._instance;
  }

  navigateTo(name: string): void {
    this.pageInfos.pushPath({ name: name });
  }

  back(): void {
    this.pageInfos.pop();
  }

  clearStackAndNavigate(name: string): void {
    this.pageInfos.clear();
    this.pageInfos.pushPath({ name: name });
  }
}

export enum Page {
  MAIN_PAGE          = 'MainPage',
  FOCUS_CONTROL_PAGE = 'FocusControlPage',
  EVENT_PAGE         = 'EventPage',
  ACCESSIBILITY_PAGE = 'AccessibilityPage'
}
