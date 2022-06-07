# posterr

Strider Mobile assessment - 2.0

## Getting Started

This project is related to a Strider Mobile assessment

- Author: Fernando Bela Ferracini

## Overview

Posterr is a new social media application. Posterr is very similar to Twitter, but it has far fewer features.
Posterr only has two screens, the home (default), and the user profile screen.

## The features implemented so far are:

### Home Screen:
- On the Home screen we have a feed with all posts from all users displayed in descending order of posting date (from newest to oldest).
- On this screen it is also possible for the active user to make new posts, reposts and posts with comments.

### User Profile screen:
- In the User Profile screen it is possible to see the data of the active user: display name, username and joined date in Posterr.
- This screen displays counters with the number of posts, reposts and quote reposts made by the user.
- This screen displays a personalized feed with only the posts, reposts and quote reposts made by the active user.
- On this screen it is also possible for the active user to make new posts, reposts and posts with comments.
- On this screen it is possible to change the active user by selecting one of the 4 preloaded users (@fernandoferracini, @lukesky, @leiaorgana, @solo).

### General business rules implemented:
- Users are not allowed to post more than 5 posts in one day (including reposts and quote posts)
- Posts can have a maximum of 777 characters
- When writing a post, a user should see how many characters she/he has left
- Users cannot update or delete their posts.

## Critique

If there was more time, so that the app could compete on an equal footing with the most important current apps, the following new features should be implemented:

### Bussines User features

#### User profile and Authentication:
- Sign on, sign in , user profile data and password maintanance.
- Language options
- Implement a clear privacy policy to be accepted for all users.

#### Posts:
- delete function
- edit(to be discussed) function.
- Possibility to insert media(image, videos).
- Possibility to share links.

#### Feed:
- Possibility of timeline display configuration (chronological, relevant content, etc)
- Possibility to "follow" other users to closely follow the content distributed by them.

### General Backend, crashes and security issues

#### BackEnd
- The app must be prepared to access a strong backend data structure in order to support assuming the scale to millions of users.
- The data model implemented must be designed with a view to scalability for millions of queries and simultaneous accesses, allowing queries with ultra-fast response times and low latency.
- The BackEnd should be thought of considering even users with slow internet connections.
- The BackEnd must be implemented using RESTful API's built within the most modern standards on the market.

#### Security and privacy issues
- The App must treat privacy as a topic of utmost importance and taking into account the GDPR of each country in which we operate.
- FrontEnd and BackEnd must be built considering the most current data security and intrusion standards determined by the "OWASP top ten"

#### Assuming you've got multiple crashes for specific models
- The design of the App must take into account different models and usage scenarios. Based on these scenarios, versions and/or tools must be built in order to test these scenarios and models under stress.
This type of treatment helps to avoid and, in case of an occurrence, better track what happens.
- The development team must be able and agile to track, isolate and create containment measures for certain scenarios.
For example: Ability to via BackEnd disable certain features or scenarios that are identified as responsible for the bugs. This gives the team time to fix the problem and release versions with the necessary fixes and minimize the impact of bugs on users.
