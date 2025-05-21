import 'package:flutter/material.dart';

class ChooseServicesCard extends StatelessWidget {
  final String serviceName;
  // final String category;
  // final String description;
  final VoidCallback onSelect; // Callback when the service is selected

  const ChooseServicesCard({Key? key, 
    required this.serviceName,
    // required this.category,
    // required this.description,
    required this.onSelect, required bool isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onSelect,  // Trigger the onSelect callback when the card is tapped
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                serviceName,  // Display the service name
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.0),
              // Text(
              //   'Category: $category',  // Display the service category
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
              // SizedBox(height: 8.0),
              // Text(
              //   description,  // Display the service description
              //   style: Theme.of(context).textTheme.bodyLarge,
              // ),
              // SizedBox(height: 8.0),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: ElevatedButton(
              //     onPressed: onSelect,  // Trigger selection on button press
              //     child: Text("Select Service"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
