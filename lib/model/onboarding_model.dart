class OnboardingModel {
  final String title;
  final String content;
  final String image;

  OnboardingModel(this.title, this.content, this.image);
}

List<OnboardingModel> contents = [
  OnboardingModel(
    'Feeling unsafe but scared to talk about it?',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pulvinar amet viverra et amet, rhoncus sollicitudin velit, consectetur. ',
    'assets/images/Scared-pana.png',
  ),
  OnboardingModel(
    'Witnessed an act of violence that no one spoke about?',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pulvinar amet viverra et amet, rhoncus sollicitudin velit, consectetur. ',
    'assets/images/Gender violence-bro.png',
  ),
  OnboardingModel(
    'We are here to make things easier and to make you feel safer',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pulvinar amet viverra et amet, rhoncus sollicitudin velit, consectetur. ',
    'assets/images/Enthusiastic-bro.png',
  ),
];
