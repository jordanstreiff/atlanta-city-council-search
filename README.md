# README

This is a codebase for an Atlanta City Council Search web application. The application allows users to find their local city council district and member by entering their address. The application is built using Ruby on Rails and utilizes Google Maps API for geocoding.

To run the application, follow these steps:

* Copy `.env.copy` to `.env` and add your google api key.
* Run `bundle install` to install necessary gems
* Run `rake db:migrate` to migrate the database
* Run `rake db:seed` to seed the database with representative data
* Run `rails s` to start the server
* To contribute, fork the repository and make a pull request.

The widget is a piece of HTML code that can be embedded into any website. It allows users to enter their address and find their local city council district and member without leaving the current website. The widget is built using Google Maps API for geocoding and retrieves the representative data from the database. The code for the widget is located in the file `public/widget.html`.

Overall, this codebase provides a simple and easy-to-use solution for Atlanta residents to find their local city council district and member.