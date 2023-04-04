# PHOTOGRAM - backend

## Author
Mark Sangiriaki

## About
Ruby on rails backend for Phototgram, an instagram-like app for sharing photos with other users. Its models include:
- User
- Post
- Like- Comment
- Comment
- Follow

## Getting Started
To get started with the application, ensure you have Ruby (version 2.7.3) and Rails installed on your computer. You can install them by following the instructions provided in the following links:
- [install Ruby:](https://www.ruby-lang.org/en/documentation/installation/)
- [install Rails:](https://guides.rubyonrails.org/getting_started.html#installing-rails)

Next you can clone this repository onto your computer by running:
- `git clone https://github.com/Mark500-lang/photogram-backend`
Then follow the steps bellow to set up dependencies:
- `cd photogram-backend`
- `bundle install`
- `db:migrate`
- `db:seed`

## Database Setup
This application uses SQLite as the database management system. You will need to have SQLite installed on your computer before you can set up the database for this application.

You can install SQLite by following the instructions provided in the following links:
- [SQLite](https://www.sqlite.org/download.html)

## Usage
To run the application, you can start the Rails server by running the following command:
- `rails s`

You can then access the application by opening your web browser and navigating to 'http://localhost:3000'.

## Models and Associations
### User Model
A User has the following relations:
- many posts
- many comments
- many likes

### Post Model
A Post has the following relations:
- belongs to a user
- many comments
- many likes

### Comments Model
A comment has the following relations:
- belongs to a user
- belongs to a post

### Like Model
A like has the following relations:
- belongs to a user
- belongs to a post

### Follow Model
- belongs to a user

## MIT License
Copyright (c) 2023 :Mark Sangiriaki
