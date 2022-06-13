class OnboardingModel {
  final String title;
  final String content;
  final String image;

  OnboardingModel(this.title, this.content, this.image);
}

List<OnboardingModel> contents = [
  OnboardingModel(
    'Feeling unsafe but scared to talk about it?',
    'We know it\'s difficult sometimes to talk about issues related to sexual misconduct. We are here to make it easy for you with MySafe Campus.',
    'assets/images/Scared-pana.png',
  ),
  OnboardingModel(
    'Witnessed an act of violence that no one spoke about?',
    'The app allows all members of the Ashesi community to report cases of sexual misconduct or of inappropriate sexual behaviour. Whether you are a witness or a survivor, the app provides you with the means to report any issue. ',
    'assets/images/Worried-bro(1).png',
  ),
  OnboardingModel(
    'We are here to make things easier and to make you feel safer',
    'Your safety is our topmost priority. In instances of imminent danger, there is a panic button that sends an alert to the Ashesi team as well as your emergency contacts, which you can add in the app',
    'assets/images/Enthusiastic-bro.png',
  ),
];
