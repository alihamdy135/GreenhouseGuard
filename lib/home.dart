import 'package:flutter/material.dart';
import 'bottom_navigator_bar.dart';

const Color kPrimaryColor = Color(0xFF2C6975);
const Color kSecondaryColor = Color(0xFF68B2A0);
const Color kAccentColor = Color(0xFFCDE0C9);
const Color kLightAccentColor = Color(0xFFE0ECDE);
const Color kBackgroundColor = Color(0xFFFFFFFF);

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _chatMessages = [];

  // Define the questions and answers in categories
  final Map<String, List<Map<String, String>>> categories = {
    'General Questions': [
      {'question': 'How often should I calibrate the sensors?', 'answer': 'It is recommended to calibrate the sensors every 6 months to ensure accurate readings.'},
      {'question': 'How can I monitor the growth stage of my tomato plants?', 'answer': 'By tracking the temperature, humidity, and light intensity, you can monitor the growth stage of your plants.'},
      {'question': 'What kind of fertilizer should I use for tomato plants?', 'answer': 'Tomato plants benefit from regular fertilization. Use a balanced fertilizer with a NPK ratio of 10-10-10 or organic fertilizers like compost or manure.'},
      {'question': 'How can I prevent pests and diseases in my greenhouse?', 'answer': 'Good hygiene practices, proper ventilation, and regular monitoring can help prevent pests and diseases. Biological control agents or organic pesticides can also be used if necessary.'},
      {'question': 'How do I know when my tomatoes are ripe?', 'answer': 'Ripe tomatoes have a deep red color and a firm, yet slightly soft texture. Taste-testing can confirm ripeness.'},
      {'question': 'How can I maximize my tomato yield?', 'answer': 'By optimizing environmental conditions, providing adequate nutrition, and preventing pests and diseases, you can increase your yield. Pruning helps direct energy toward fruit production.'},
    ],
    'Temperature Questions': [
      {'question': 'What is the ideal temperature range for growing tomatoes?', 'answer': 'During the day, the optimal temperature is 21–27°C (70–80°F), and at night, it is 16–20°C (60–68°F).'},
      {'question': 'What are the effects of temperatures outside the optimal range?', 'answer': 'High temperatures (above 32°C) can cause flower drop and poor fruit set, while low temperatures (below 10°C) slow growth and delay flowering.'},
      {'question': 'How can I control the temperature in the greenhouse?', 'answer': 'Use ventilation, shading, or cooling systems to reduce high temperatures and heaters to raise low temperatures.'},
    ],
    'Humidity Questions': [
      {'question': 'What should I do if I receive a low humidity alert?', 'answer': 'Low humidity can stress plants. Increase humidity levels by misting or using a humidifier.'},
      {'question': 'What is the ideal humidity level for tomatoes?', 'answer': 'Tomatoes grow best in relative humidity levels between 65–85%.'},
      {'question': 'What are the effects of high or low humidity?', 'answer': 'High humidity increases the risk of fungal diseases like powdery mildew, while low humidity causes water stress, leading to poor fruit development.'},
      {'question': 'How can I control the humidity in the greenhouse?', 'answer': 'Use ventilation systems, dehumidifiers, or misting systems based on the humidity sensor readings.'},
    ],
    'Light Intensity Questions': [
      {'question': 'What is the optimal light intensity for tomato plants?', 'answer': 'Tomato plants require ample sunlight. Aim for at least 10 hours of sunlight per day. If natural light is insufficient, supplement with artificial lighting.'},
      {'question': 'How does light intensity affect tomato growth?', 'answer': 'Insufficient light leads to weak stems, fewer flowers, and poor fruit development. Excessive light can cause leaf burn and dehydration.'},
      {'question': 'What should I do if the light intensity drops below optimal levels?', 'answer': 'Use grow lights or supplemental LED lighting to maintain the required intensity during cloudy days or shorter daylight hours.'},
    ],
    'Soil Moisture Questions': [
      {'question': 'How often should I water my tomato plants?', 'answer': 'The frequency of watering depends on factors like soil moisture, temperature, and humidity. Use the soil moisture sensor to determine watering needs.'},
      {'question': 'What is the ideal soil moisture level for tomatoes?', 'answer': 'Tomatoes grow best when soil moisture is maintained in the range of 400 to 600 ADC.'},
      {'question': 'What happens if the soil is too dry or too wet?', 'answer': 'Dry soil causes stress, leading to wilting and reduced fruit production. Overwatering can result in root rot and fungal diseases.'},
      {'question': 'How can I ensure optimal soil moisture in the greenhouse?', 'answer': 'Use moisture sensor readings to automate irrigation systems or adjust manual watering schedules.'},
    ],
  };

  String? selectedCategory;
  String? selectedQuestion;
  String? answer;

  // Add user message to chat history
  void _sendMessage(String message) {
    setState(() {
      _chatMessages.add({'sender': 'user', 'message': message});
    });
  }

  // Add bot's answer to chat history
  void _sendBotAnswer(String question) {
    setState(() {
      selectedQuestion = question;
      final categoryQuestions = categories[selectedCategory!];
      final questionData = categoryQuestions!.firstWhere((qa) => qa['question'] == question);
      answer = questionData['answer'];

      // Adding bot's response to chat history
      _chatMessages.add({'sender': 'bot', 'message': answer!});
    });
  }

  // Show the questions for the selected category
  void _showQuestions(String category) {
    setState(() {
      selectedCategory = category;
      selectedQuestion = null;
      answer = null;
      _sendMessage('I would like to know about $category');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Bot'),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // To show the most recent message at the bottom
              padding: const EdgeInsets.all(16.0),
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final chatMessage = _chatMessages[index];
                return Align(
                  alignment: chatMessage['sender'] == 'user'
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      color: chatMessage['sender'] == 'user' ? kSecondaryColor : kAccentColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      chatMessage['message']!,
                      style: TextStyle(
                        color: chatMessage['sender'] == 'user' ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Category selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              hint: const Text("Choose Category"),
              value: selectedCategory,
              onChanged: (category) {
                setState(() {
                  selectedCategory = category;
                  selectedQuestion = null; // reset question selection
                });
                _sendMessage("I would like to know about $category");
              },
              items: categories.keys.map<DropdownMenuItem<String>>((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
            ),
          ),
          // Show questions after category selection
          if (selectedCategory != null) 
            Expanded(
              child: ListView.builder(
                itemCount: categories[selectedCategory]!.length,
                itemBuilder: (context, index) {
                  final questionData = categories[selectedCategory]![index];
                  return ListTile(
                    title: Text(questionData['question']!),
                    onTap: () {
                      _sendMessage(questionData['question']!);
                      _sendBotAnswer(questionData['question']!);
                    },
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Ask me a question...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onSubmitted: (message) {
                      _sendMessage(message);
                      _sendBotAnswer(message);
                      _messageController.clear();
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final message = _messageController.text;
                    if (message.isNotEmpty) {
                      _sendMessage(message);
                      _sendBotAnswer(message);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushReplacementNamed('chartscreen');
          } else if (index == 2) {
            Navigator.of(context).pushReplacementNamed('Safe');
          }
        },
      ),
    );
  }
}
