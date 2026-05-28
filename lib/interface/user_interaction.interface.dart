abstract interface class UserInteraction {
  void buttonClick(String buttonName, {Map<String, dynamic>? properties});

  void navigation(String fromPageName, String toPageName);

  void onScreen(String pageName);

  void onTap(String content);
}
