class Mood {
  final String emoji;
  final String label;
  const Mood(this.emoji, this.label);
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
      Mood('😊', 'Happy'),
      Mood('😌', 'Calm'),
      Mood('😢', 'Sad'),
      Mood('😠', 'Angry'),
      Mood('😰', 'Anxious'),
      Mood('😴', 'Tired'),
      Mood('🥰', 'Loved'),
      Mood('🤩', 'Excited'),
      Mood('😕', 'Confused'),
    ],
  ),
  MoodQuestion(
    highlight: 'How',
    rest: ' is your energy level?',
    subtitle: 'Think about your physical energy right now',
    moods: [
      Mood('⚡', 'Electric'),
      Mood('🔥', 'Pumped'),
      Mood('😤', 'Driven'),
      Mood('🙂', 'Steady'),
      Mood('😐', 'Neutral'),
      Mood('🥱', 'Low'),
      Mood('😪', 'Drained'),
      Mood('💤', 'Dead'),
      Mood('🌀', 'Scattered'),
    ],
  ),
  MoodQuestion(
    highlight: 'How',
    rest: ' is your focus today?',
    subtitle: 'How well can you concentrate right now',
    moods: [
      Mood('🎯', 'Locked in'),
      Mood('🧠', 'Sharp'),
      Mood('📖', 'Studying'),
      Mood('🙂', 'OK'),
      Mood('😑', 'Meh'),
      Mood('💭', 'Drifting'),
      Mood('😵‍💫', 'Spinning'),
      Mood('🌫️', 'Foggy'),
      Mood('📵', 'Offline'),
    ],
  ),
  MoodQuestion(
    highlight: 'How',
    rest: ' do you feel socially?',
    subtitle: 'Your vibe around other people today',
    moods: [
      Mood('🎉', 'Social'),
      Mood('🤗', 'Warm'),
      Mood('😊', 'Open'),
      Mood('🙂', 'Fine'),
      Mood('😶', 'Quiet'),
      Mood('🚪', 'Withdrawn'),
      Mood('😔', 'Lonely'),
      Mood('😤', 'Irritable'),
      Mood('🧍', 'Isolated'),
    ],
  ),
  MoodQuestion(
    highlight: 'How',
    rest: ' do you feel about today?',
    subtitle: 'Your overall outlook on the rest of the day',
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
