# Movs

[![Actions Status](https://github.com/luis-gustavo/ios-recruiting-brazil/workflows/CI/badge.svg)](https://github.com/luis-gustavo/ios-recruiting-brazil/actions)

Movs is an iOS app based on the [Concrete Solutions iOS Recruiting Challenge](https://github.com/concretesolutions/ios-recruiting-brazil). It is an app that consumes data from [TheMovieDB API](https://developers.themoviedb.org/3/getting-started/introduction) and presents the current popular movies, allowing the user to view the movie details and favorite movies.

![App's preview](https://github.com/luis-gustavo/ios-recruiting-brazil/blob/dev/app-preview/app-preview.gif)

It was created with the latest Apple's technologies like and Combine.

## App's architecture

The architecture used on this project was MVVM because of the reasons below:

* Easy to use
* Distributed responsabilities 
* Easy to test
* Matches well with Combine

## Continuous Integration

Continuous integration was configured using Github Actions. The current build status is:

[![Actions Status](https://github.com/luis-gustavo/ios-recruiting-brazil/workflows/CI/badge.svg)](https://github.com/luis-gustavo/ios-recruiting-brazil/actions)

## Possible improvements

* Add dark mode (now it's ligh mode only)
* Add Snapshot tests
* Add Continuos deploy
* Add filter on favorited movies screen
