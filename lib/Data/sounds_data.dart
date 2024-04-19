class SoundModel {
  final String name;
  final String url;
  bool isSelected;

  SoundModel({required this.name, required this.url, required this.isSelected});
}

final List<SoundModel> sounds = [
  SoundModel(
      name: 'Alarm Siren',
      url: 'assets/sounds/alarm-car.mp3',
      isSelected: false),
  SoundModel(
      name: 'Defense Siren',
      url: 'assets/sounds/civil-defense-siren.mp3',
      isSelected: false),
  SoundModel(
    name: 'General',
    url: 'assets/sounds/general.wav',
    isSelected: false,
  ),
  SoundModel(
      name: 'Police Siren',
      url: 'assets/sounds/police-car-siren.mp3',
      isSelected: false),
];
