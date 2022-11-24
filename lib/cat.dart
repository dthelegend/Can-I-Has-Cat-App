import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:math';

// Write a python array of 50 cat names
const List<String> catNames = [
  'Amber',
  'Bella',
  'Charlie',
  'Daisy',
  'Ella',
  'Frankie',
  'Ginger',
  'Harriet',
  'Inky',
  'Jasper',
  'Kitty',
  'Lola',
  'Molly',
  'Natalie',
  'Olivia',
  'Pebbles',
  'Queeny',
  'Ruby',
  'Sophie',
  'Tabby',
  'Violet',
  'Willow',
  'Zoey',
  'Albert',
  'Buttercup',
  'Cinnamon',
  'Dodge',
  'Fidget',
  'Harvey',
  'Jinx',
  'Kipper',
  'Lucky',
  'Max',
  'Oscar',
  'Pumpkin',
  'Tigger',
  'Whiskers',
  'Yin',
  'Yang',
  'Ziggy',
  'Annie',
  'Bear',
  'Callie',
  'Duchess',
  'Emily',
  'Fluffy',
  'Gizmo',
  'Kitten',
  'Lucy',
  'Missy',
  'Patches',
  'Princess',
  'Sandy',
  'Simba',
  'Smokey',
  'Snowball',
  'Tinkerbell'
];

// Write a python array of 50 cat personality descriptions
const catPersonalities = [
  'laid back',
  'affectionate',
  'curious',
  'playful',
  'sociable',
  'friendly',
  'easygoing',
  'impulsive',
  'shy',
  'timid',
  'bold',
  'outgoing',
  'adventurous',
  'active',
  'lazy',
  'cuddly',
  ' independent',
  'sweet',
  'sassy',
  'strong',
  'stubborn',
  'intelligent',
  'sensitive',
  'observant',
  'alert',
  'calm',
  'grumpy',
  'docile',
  ' aggressive',
  'passive',
  'quiet',
  'noisy',
  'energetic',
  'loud',
  'soft',
  'talkative',
  'meek',
  'rude',
  'grouchy',
  'cranky',
  'jumpy',
  'nervous',
  'anxious',
  'fearful',
  'distrusting',
  'trusting',
  'loving',
  'affectionate',
  'sentimental'
];

// Write a python array of 50 cat activities
const catActivities = [
  'eating',
  'sleeping',
  'playing',
  'purring',
  'cuddling',
  'licking',
  'rolling around',
  'stretching',
  'yawning',
  'chasing',
  'jumping',
  'climbing',
  'scratching',
  'grooming',
  'meowing',
  'hissing',
  'peeking',
  'hide and seek',
  'sleeping in a sunny spot',
  'napping',
  'laying in a sunny spot',
  'laying in a warm spot',
  'laying in a cool spot',
  'laying in a shady spot',
  'laying in a soft spot',
  'knocking things off of surfaces',
  'begging for food',
  'begging for attention',
  'watching birds',
  'watching squirrels',
  'watching people',
  'playing with a toy',
  'playing with a ball of yarn',
  'playing with a catnip toy',
  'playing with a string',
  'playing with a feather',
  'playing with a piece of paper',
  'playing with a crumpled up piece of paper',
  'playing with a pen or pencil',
  ' chewing on a pen or pencil',
  'eating a pen or pencil',
  'sleeping in a laundry basket',
  'sleeping in a box'
];

class Cat {
  final Uint8List imageBuffer;
  final String name;
  final String personality;
  final List<String> favouriteActivities;
  final List<String> dislikedActivities;

  const Cat({
    required this.imageBuffer,
    required this.name,
    required this.personality,
    required this.dislikedActivities,
    required this.favouriteActivities,
  });

  factory Cat.fromImageBuffer(Uint8List imageBuffer) {
    var sumOfBuffer = imageBuffer.fold(0, (p, c) => p + c);
    var random = Random(sumOfBuffer);
    var name = catNames[random.nextInt(catNames.length)];
    var personality = catPersonalities[random.nextInt(catPersonalities.length)];
    var favouriteActivities = [
      catActivities[random.nextInt(catActivities.length)],
      catActivities[random.nextInt(catActivities.length)],
      catActivities[random.nextInt(catActivities.length)]
    ];
    var dislikedActivities = [
      catActivities[random.nextInt(catActivities.length)],
      catActivities[random.nextInt(catActivities.length)],
      catActivities[random.nextInt(catActivities.length)]
    ];
    return Cat(imageBuffer: imageBuffer, name: name, personality: personality, dislikedActivities: dislikedActivities, favouriteActivities: favouriteActivities);
  }
}

Future<Cat> fetchNonExistentCat() async {
  final response =
      await http.get(Uri.parse("https://thiscatdoesnotexist.com/"));
  if (response.statusCode == 200) {
    return Cat.fromImageBuffer(response.bodyBytes);
  } else {
    throw Exception("Failed to get Cat");
  }
}
