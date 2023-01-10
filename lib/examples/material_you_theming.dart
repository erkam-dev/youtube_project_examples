import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MaterialYouTheming extends StatefulWidget {
  const MaterialYouTheming({super.key});

  @override
  State<MaterialYouTheming> createState() => _MaterialYouThemingState();
}

class _MaterialYouThemingState extends State<MaterialYouTheming> {
  ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

  int _currentIndex = 0;
  double sliderValue = 0.5;
  bool switchValue = false;

  bool useMaterial3 = true;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: brandColor);
          darkColorScheme = ColorScheme.fromSeed(
              seedColor: brandColor, brightness: Brightness.dark);
        }
        return ValueListenableBuilder(
          valueListenable: themeNotifier,
          builder: (_, ThemeMode currentTheme, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: useMaterial3,
                colorScheme: lightColorScheme,
              ),
              darkTheme: ThemeData(
                useMaterial3: useMaterial3,
                colorScheme: darkColorScheme,
                // brightness: Brightness.dark,
              ),
              themeMode: currentTheme,
              home: Scaffold(
                  appBar: AppBar(
                    title: const Text('Material You'),
                    actions: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.adaptive.more))
                    ],
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Aydınlık / Karanlık Tema'),
                            Switch(
                              value: switchValue,
                              onChanged: (value) {
                                value == false
                                    ? setState(() => themeNotifier =
                                        ValueNotifier(ThemeMode.light))
                                    : setState(() => themeNotifier =
                                        ValueNotifier(ThemeMode.dark));
                                setState(() {
                                  switchValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Material 3'),
                            Switch(
                              value: useMaterial3,
                              onChanged: (value) {
                                setState(() {
                                  useMaterial3 = value;
                                });
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text('Elevated Button')),
                        OutlinedButton(
                            onPressed: () {},
                            child: const Text('Outlined Button')),
                        TextButton(
                            onPressed: () {}, child: const Text('Text Button')),
                        Chip(
                          label: const Text('Chip'),
                          avatar: const Icon(Icons.account_circle_rounded),
                          onDeleted: () {},
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(children: const [
                                FlutterLogo(),
                                Text('Card Example')
                              ]),
                            ),
                          ),
                        ),
                        Slider(
                          value: sliderValue,
                          onChanged: (value) =>
                              setState(() => sliderValue = value),
                        ),
                      ],
                    ),
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                  bottomNavigationBar: useMaterial3
                      ? NavigationBar(
                          selectedIndex: _currentIndex,
                          onDestinationSelected: (value) =>
                              setState(() => _currentIndex = value),
                          destinations: const [
                            NavigationDestination(
                                icon: Icon(Icons.home_rounded),
                                label: "Anasayfa"),
                            NavigationDestination(
                                icon: Icon(Icons.search_rounded),
                                label: "Arama"),
                            NavigationDestination(
                                icon: Icon(Icons.message_rounded),
                                label: "Mesajlar"),
                            NavigationDestination(
                                icon: Icon(Icons.settings_rounded),
                                label: "Ayarlar"),
                          ],
                        )
                      : BottomNavigationBar(
                          currentIndex: _currentIndex,
                          onTap: (value) =>
                              setState(() => _currentIndex = value),
                          items: const [
                            BottomNavigationBarItem(
                                icon: Icon(Icons.home_rounded),
                                label: "Anasayfa"),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.search_rounded),
                                label: "Arama"),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.message_rounded),
                                label: "Mesajlar"),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.settings_rounded),
                                label: "Ayarlar"),
                          ],
                          unselectedItemColor: Colors.grey,
                          selectedItemColor: Colors.blue,
                        )),
            );
          },
        );
      },
    );
  }
}
