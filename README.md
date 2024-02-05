
# Flutter_AIML

A plugin for using aiml on flutter on Android.


## Installation

add this to your pubspec.yaml file

flutter_aiml:
    git:
      url: https://github.com/ameyreghu/flutter_aiml.git
      ref: main

## Adding AIML files

add the aiml files to

Android
  - app
    - src
      - main  
        - assets
          - AIML

refer example

## Min Sdk 
update app level buil.gradle

minSdkVersion 22


## Usage

 FlutterAiml aiml = FlutterAiml() ;

 aiml.invokeSetup();  //to setup the aiml files for the aiml bot

var response = await aiml.getResponse(message: 'HI'); 


for more refer the example .


