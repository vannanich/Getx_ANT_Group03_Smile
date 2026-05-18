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
      Mood('😤', 'Focus'),
      Mood('assets/Feeling/smile.png', 'Happiness'),
      Mood('assets/Feeling/self_love.png', 'Sleep'),
      Mood('🥱', 'Self-Love'),
      Mood('😪', 'Clarity'),
      Mood('💤', 'Energy'),
      Mood('assets/Feeling/connection.png', 'Connection'),
    ],
  ),
  MoodQuestion(
    highlight: 'What',
    rest: ' is your goal today ?',
    subtitle: 'How well can you concentrate right now',
    moods: [
      Mood('🎯', 'Relax'),
      Mood('🧠', 'Chill'),
      Mood('📖', 'Be Productive'),
      Mood('🙂', 'Work Out'),
      Mood('😑', 'Learn'),
      Mood('💭', 'Create'),
      Mood('😵‍💫', 'Heal'),
      Mood('🌫️', 'Socialize'),
      Mood('📵', 'Rests'),
    ],
  ),
  MoodQuestion(
    highlight: 'What',
    rest: ' make you smile ?',
    subtitle: 'Pick the thing that brings you the most joy',
    moods: [
      Mood('🎉', 'Family & Friends'),
      Mood('🤗', 'Nature'),
      Mood('😊', 'Music'),
      Mood('🙂', 'Animals'),
      Mood('😶', 'Food'),
      Mood('🚪', 'Travel'),
      Mood('😔', 'Books'),
      Mood('😤', 'Games'),
      Mood('🧍', 'Art'),
    ],
  ),
  MoodQuestion(
    highlight: 'What',
    rest: ' skill are you building?',
    subtitle: 'Choose the skill you want to grow',
    moods: [
      Mood('🌟', 'Mindfulness'),
      Mood('😄', 'Communication'),
      Mood('🙂', 'Time\n Management'),
      Mood('😐', 'Discipline'),
      Mood('😕', 'Focus'),
      Mood('😞', 'Self-Care'),
      Mood('😢', 'Critical Thinking'),
      Mood('😩', 'Leadership'),
      Mood('🌧️', 'Creativity '),
    ],
  ),
  MoodQuestion(
    highlight: 'How',
    rest: ' can we help you?',
    subtitle: 'Tell us what you need right now',
    moods: [
      Mood('🌟', 'Amazing'),
      Mood('😄', 'Good'),
      Mood('🙂', 'Alright'),
      Mood('😐', 'Neutral'),
      Mood('😕', 'Unsure'),
      Mood('😞', 'Not great'),
      Mood('😢', 'Rough'),
      Mood('😩', 'Tough'),
      Mood('🌧️', 'Dark'),
    ],
  ),
];
