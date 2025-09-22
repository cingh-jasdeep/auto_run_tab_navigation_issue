import 'package:auto_route/auto_route.dart';
import 'package:auto_run_tab_navigation_issue/main.gr.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(
      path: '/',
      page: HomeRoute.page,
      children: [
        AutoRoute(path: 'tab1', page: Tab1Route.page),
        AutoRoute(path: 'tab2', page: Tab2Route.page),
        AutoRoute(path: 'tab1detail', page: Tab1DetailRoute.page),
      ],
    ),
    AutoRoute(path: '/settings', page: SettingsRoute.page),
  ];
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _appRouter.config());
  }
}

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [Tab1Route(), Tab2Route()],
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
              case 1:
                tabsRouter.setActiveIndex(index);
              case 2:
                context.pushRoute(SettingsRoute());
              default:
                break;
            }
          },
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(Icons.explore),
              icon: Icon(Icons.explore_outlined),
              label: "Tab 1",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.library_books),
              icon: Icon(Icons.library_books_outlined),
              label: "Tab 2",
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.settings),
              icon: Icon(Icons.settings_outlined),
              label: "Settings",
            ),
          ],
        );
      },
    );
  }
}

@RoutePage()
class Tab1Screen extends StatelessWidget {
  const Tab1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("tab 1"),
            FilledButton(
              onPressed: () {
                context.pushRoute(Tab1DetailRoute());
              },
              child: Text("Detail screen"),
            ),
          ],
        ),
      ),
    );
  }
}

@RoutePage()
class Tab1DetailScreen extends StatelessWidget {
  const Tab1DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("tab 1 detail")));
  }
}

@RoutePage()
class Tab2Screen extends StatelessWidget {
  const Tab2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("tab 2")));
  }
}

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Settings")));
  }
}
