import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pragatiproject/Provider/volunteer_provider.dart';
class VolunteeringRegistrationPage extends StatefulWidget {
  @override
  _VolunteeringRegistrationPageState createState() =>
      _VolunteeringRegistrationPageState();
}

class _VolunteeringRegistrationPageState
    extends State<VolunteeringRegistrationPage> {

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController additionalInfoController = TextEditingController();
  String? selectedCity;
  String? selectedState;
  String? selectedAvailability;
  List<String> selectedSkills = [];
  // Dummy Data
  final List<String> cities = [
    'Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Thane', 'Aurangabad', 'Solapur',
    'Amravati', 'Kolhapur', 'Latur', 'Akola', 'Sangli', 'Jalgaon', 'Nanded',
    'Dhule', 'Ahmednagar', 'Chandrapur', 'Parbhani', 'Bhiwandi', 'Malegaon',
    'Satara', 'Alibag', 'Beed', 'Ratnagiri', 'Wardha', 'Yavatmal', 'Osmanabad',
    'Panvel', 'Kalyan-Dombivli', 'Vasai-Virar', 'Ulhasnagar'
  ];
  final List<String> states = [ 'Maharashtra'];
  final List<String> skills = ['First Aid', 'Crowd Management', 'Cooking',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteering Registration'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Text(
                "Join us in making the Dindi Yatra a memorable experience!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),

              // Full Name
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Please enter your full name" : null,
              ),
              SizedBox(height: 10),

              // Email Address
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email Address",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.contains('@')
                    ? null
                    : "Please enter a valid email address",
              ),
              SizedBox(height: 10),

              // Mobile Number
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.length == 10
                    ? null
                    : "Please enter a valid mobile number",
              ),
              SizedBox(height: 10),

              // Address
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                value!.isEmpty ? "Please enter your address" : null,
              ),
              SizedBox(height: 10),

              // City Dropdown
              DropdownButtonFormField<String>(
                value: selectedCity,
                decoration: InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                ),
                items: cities
                    .map((city) => DropdownMenuItem(
                  value: city,
                  child: Text(city),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value!;
                  });
                },
                validator: (value) =>
                value == null ? "Please select a city" : null,
              ),
              SizedBox(height: 10),

              // State Dropdown
              DropdownButtonFormField<String>(
                value: selectedState,
                decoration: InputDecoration(
                  labelText: "State",
                  border: OutlineInputBorder(),
                ),
                items: states
                    .map((state)  => DropdownMenuItem(
                  value: state,
                  child: Text(state),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedState = value!;
                  });
                },
                validator: (value) =>
                value == null ? "Please select a state" : null,
              ),
              SizedBox(height: 10),

              // Skills Multi-select
              Wrap(
                spacing: 8.0,
                children: skills
                    .map((skill) => FilterChip(
                  label: Text(skill),
                  selected: selectedSkills.contains(skill),
                  onSelected: (isSelected) {
                    setState(() {
                      isSelected
                          ? selectedSkills.add(skill)
                          : selectedSkills.remove(skill);
                    });
                  },
                ))
                    .toList(),
              ),
              SizedBox(height: 10),

              // Availability Dropdown
              DropdownButtonFormField<String>(
                value: selectedAvailability,
                decoration: InputDecoration(
                  labelText: "Availability",
                  border: OutlineInputBorder(),
                ),
                items: ['Morning', 'Afternoon', 'Evening', 'Full Day']
                    .map((availability) => DropdownMenuItem(
                  value: availability,
                  child: Text(availability),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAvailability = value!;
                  });
                },
                validator: (value) =>
                value == null ? "Please select your availability" : null,
              ),
              SizedBox(height: 10),

              // Additional Information
              TextFormField(
                controller: additionalInfoController,
                decoration: InputDecoration(
                  labelText: "Why do you want to volunteer?",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 10),

              // Submit Button

              GestureDetector(
                onTap: (){
                  print("Tapped on Submitt");
                  if(_formKey.currentState!.validate()){

                    Provider.of<VolunteeringProvider>(context,listen: false).registerVolunteer(
                      name: nameController.text,
                      email: emailController.text,
                      mobile: phoneController.text,
                      address: addressController.text,
                      city: selectedCity!,
                      state: selectedState!,
                      skills: selectedSkills, // Pass the selectedSkills list
                      availability: selectedAvailability!,
                      additionalInfo: additionalInfoController.text,
                      context: context,
                    // List<String> selectedSkills = [];
                    );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(

                    color: Colors.orangeAccent,

                    borderRadius: BorderRadius.circular(10),

                  ),

                  child: Center(
                    child: Text('Register', style: TextStyle(color: Colors.white)),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
