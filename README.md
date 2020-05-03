# Sports Talk - iOS Demo

This app demonstrate the usage of [Sports Talk SDK](https://gitlab.com/sportstalk247/sdk-ios-swift). This App contains two sections
### 1. Chat Section: There are two screens under this section

a)  Choose User: you can choose any demo user from the list

b)  Chat: You can send messages in a predefined chat room and even like a message by tapping on thumbs up icon. The messages will be sent from the demo user that you've chosen in the previous screen, you can go back and select another user to see those message on the left side.


### 2. Comments Section: There are two screens under this section

a) Conversation Screen: Here you can see a list of conversations, choose any

b) Comment Screen: Here you can send comments in the chosen conversation. additionally you can like a comment or report a comment.


# Installation Guide

## Minimum Requirement:
Xcode 11.4

iOS Version: 13.2

## Setup the Code on your MAC:

There are two ways to setup this code on your MAC

### 1. Clone the repository:

You can use your favourite Git Client to clone the repo or by using command line. Following are some good tutorials on how to use:

 a) By using GitHub Desktop App to clone the repository: https://learn.hibbittsdesign.org/gitlab-githubdesktop/cloning-a-gitlab-repo

 b) By command line: https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html

### 2. Download the source code as Zip.

There is a download icon button next to Find File button. From there you can download the repository as zip or other compressed methods. Download the repo and extract the repo at your desired location.

## Building and Installing the Demo App:

The SDK is already included in this project, so you don't need to POD install separately. Open the project by double clicking on 'SportsTask_iOS_Sdk_Demo.xcworkspace'

### Installing the App on Simulator:

a) Select your desired simulator 

b) Click on play button. 

### Installing the App on your iPhone:

Assuming that you have a valid Developer Account.

a) Click on the top most SportsTask_iOS_Sdk_Demo

b) Select the SportsTask_iOS_Sdk_Demo under TARGETS if not already selected. 

c) Select Signing & Capabilities

d) Make sure Automatically manage signing is checked and choose your team.

e) Connect your iPhone to your mac and select your target to your iPhone if not automatically selected.

f) Click the play button.

## Troubleshoot:

### Installing the App on iPhone via XCode:

If you encounter a problem like "An App ID with Identifier 'com.xxxx.xxx' is not available". Then follow these steps

a) Uncheck the Automatically manage signing and go to General

b) Change the bundle identifier to something unique under Identity

c) Go back to Signing & Capabilities and check the Automatically manage signing. Xcode should now automatically register the new bundle id under your account

### Broken Functionality:

if you see something is not working. like messages are not being sent in the Chat Room, try enabling **services.debug** from AppDelegate. it will print the URL, request parameters and response from the API, It can help you determine what is causing the error.
