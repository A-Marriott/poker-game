# Poker game

Poker game is an app that allows you to input a 5 card poker hand, and find out the best possible rank for said hand. For example, inputting:

- Jack of Hearts
- 5 of Diamonds
- 5 of Clubs
- Jack of Spades
- 5 of Spades

Would output Full House.

## Setup

Poker game requires Ruby (version 2.6), Ruby on Rails (version 6.0) to run.

[Follow this link to set up Ruby and Ruby on Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails).

Once these steps are complete, you have all the software needed to run the app. You should now fork the repo, and navigate inside the repo in your CLI. Once inside, run the following commands, downloading all of the dependencies you will need:

```bash
bundle install
yarn install
```
You are now ready to start your server. Run the following command in your CLI:

```bash
rails s
```

Once the server is up and running, you should now be able to navigate to the following webpage:

<http://localhost:3000/input>

Type a poker hand into the input box, following the format given (for example, 'JH 5D 5C JS 5S'). You will see the best poker rank available from that hand. Enjoy!

## Testing

A number of unit tests have been written for this app. The tests can be found in the spec folder. In order to run these tests, run the following command:

```bash
rake
```
