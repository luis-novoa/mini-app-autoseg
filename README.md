# To-Do List

In this project, I developed a to-do list app. This project is a challenge from the brazilian company Autoseg.

## Features
- Authentication and Authorization (Devise).
- Create lists with as many items and subitems as you want, from the same form.
- Share public to-do lists with the world!
- Found an interesting list? Mark it as a favorite!

## Future Improvements
- Live notifications, to always know when your favorite lists get updated.
- Improvements on the database queries to make the app faster.
- Expand the automated tests for favorites and the page for editing lists.

## Technologies Used
- Ruby 2.7.1
- Rails 6.0.3
- Jquery
- SQLite
- Devise
- FactoryBot

## Pre-Requisites
- Ruby 2.7.1
- Rails 6.0.3
- Git
- A browser with JavaScript enabled

## Installation

1 - Download this project through `git clone`. If you're unsure on how to do that, open your command line and run each command (instructions for UNIX-based systems):

```
$ mkdir todolist
$ cd todolist
$ git clone git@github.com:luis-novoa/mini-app-autoseg.git
$ cd mini-app-autoseg
```

2 - Now that you're in the folder through the command line, run `bundle install` to automatically install all the gems required by the project.

3 - Initiate your database running `rails db:migrate`.

4 - Start your server with `rails s`

5 - Using your favorite browser, visit http://0.0.0.0:3000/ .

6 - By this point you should be viewing the Login page of the app. Enjoy!

## Automated Tests

This app was developed using the TDD methodology. So far, 54 tests were developed to ensure the good functioning of the app. You can check them running `rspec --format documentation`.

## Author

👤 **Luis Novoa**

- GitHub: [luis-novoa](https://github.com/luis-novoa)
- Twitter: [@LuisMatteNovoa](https://twitter.com/LuisMatteNovoa)
- Linkedin: [Luis Novoa](https://www.linkedin.com/in/luismattenovoa/)

## 🤝 Contributing

Contributions and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!