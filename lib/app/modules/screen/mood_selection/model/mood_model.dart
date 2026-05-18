class Mood {
  final String imagePath;
  final String label;
  const Mood(this.imagePath, this.label);
}

class MoodQuestion {
  final String highlight;
  final String rest;
  final String subtitle;
  final List<Mood> moods;

  const MoodQuestion({
    required this.highlight,
    required this.rest,
    required this.subtitle,
    required this.moods,
  });
}

const List<MoodQuestion> questions = [
  MoodQuestion(
    highlight: 'How',
    rest: ' are you feeling today?',
    subtitle: 'Pick the mood that best describes you right now',
    moods: [
      Mood('assets/Feeling/sleep.png', 'Happy'),
      Mood('assets/Feeling/calm.png', 'Calm'),
      Mood('assets/Feeling/sad.png', 'Sad'),
      Mood('assets/Feeling/angry.png', 'Angry'),
      Mood('assets/Feeling/anxious.png', 'Anxious'),
      Mood('assets/Feeling/sleep.png', 'Tired'),
      Mood('assets/Feeling/love.png', 'Loved'),
      Mood('assets/Feeling/exited.png', 'Excited'),
      Mood('assets/Feeling/wonder.png', 'Confused'),
    ],
  ),
  MoodQuestion(
    highlight: 'What',
    rest: ' do you need the most ?',
    subtitle: 'Choose what matter the most to you right now',
    moods: [
      Mood('assets/Feeling/motivation.png', 'Motivation'),
      Mood('assets/Feeling/calmm.png', 'Calm'),
      Mood('assets/Feeling/💡.png', 'Focus'),
      Mood('assets/Feeling/smile.png', 'Happiness'),
      Mood('assets/Feeling/self_love.png', 'Sleep'),
      Mood('assets/Feeling/self_love.png', 'Self-Love'),
      Mood('assets/Feeling/clority.png', 'Clarity'),
      Mood('assets/Feeling/⚡.png', 'Energy'),
      Mood('assets/Feeling/🤝.png', 'Connection'),
    ],
  ),
  MoodQuestion(
    highlight: 'What',
    rest: ' is your goal today ?',
    subtitle: 'How well can you concentrate right now',
    moods: [
      Mood('assets/Feeling/🛋️.png', 'Relax'),
      Mood('assets/Feeling/🧊.png', 'Chill'),
      Mood('assets/Feeling/🎯.png', 'Be Productive'),
      Mood('assets/Feeling/🏋️.png', 'Work Out'),
      Mood('assets/Feeling/📖.png', 'Learn'),
      Mood('assets/Feeling/🎨.png', 'Create'),
      Mood('assets/Feeling/🌿.png', 'Heal'),
      Mood('assets/Feeling/🤝.png', 'Socialize'),
      Mood('assets/Feeling/sleep.png', 'Rests'),
    ],
  ),
  MoodQuestion(
    highlight: 'What',
    rest: ' make you smile ?',
    subtitle: 'Pick the thing that brings you the most joy',
    moods: [
      Mood('assets/Feeling/👨_👩_👧_👦.png', 'Family & Friends'),
      Mood('assets/Feeling/🌿.png', 'Nature'),
      Mood('assets/Feeling/🎵.png', 'Music'),
      Mood('assets/Feeling/🐾.png', 'Animals'),
      Mood('assets/Feeling/🍕.png', 'Food'),
      Mood('assets/Feeling/✈️.png', 'Travel'),
      Mood('assets/Feeling/📚.png', 'Books'),
      Mood('assets/Feeling/🎮.png', 'Games'),
      Mood('assets/Feeling/🎨.png', 'Art'),
    ],
  ),
  MoodQuestion(
    highlight: 'What',
    rest: ' skill are you building?',
    subtitle: 'Choose the skill you want to grow',
    moods: [
      Mood('assets/Feeling/calmm.png', 'Mindfulness'),
      Mood('assets/Feeling/💬.png', 'Communication'),
      Mood('assets/Feeling/⏰.png', 'Time\n Management'),
      Mood('assets/Feeling/motivation.png', 'Discipline'),
      Mood('assets/Feeling/🎯.png', 'Focus'),
      Mood('assets/Feeling/self_love.png', 'Self-Care'),
      Mood('assets/Feeling/clority.png', 'Critical Thinking'),
      Mood('assets/Feeling/connection.png', 'Leadership'),
      Mood('assets/Feeling/🎨.png', 'Creativity '),
    ],
  ),
  MoodQuestion(
    highlight: 'How',
    rest: ' can we help you?',
    subtitle: 'Tell us what you need right now',
    moods: [
      Mood('assets/Feeling/calmm.png', 'Amazing'),
      Mood('assets/Feeling/sleep.png', 'Good'),
      Mood('assets/Feeling/💡.png', 'Alright'),
      Mood('assets/Feeling/🏋️.png', 'Neutral'),
      Mood('assets/Feeling/🫂.png', 'Unsure'),
      Mood('assets/Feeling/clority.png', 'Not great'),
      Mood('assets/Feeling/self_love.png', 'Rough'),
      Mood('assets/Feeling/⚡.png', 'Tough'),
      Mood('assets/Feeling/🎯.png', 'Dark'),
    ],
  ),
];
