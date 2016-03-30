# Event Calendar

This is a RoR challenge that displays events for different tracks on a table. Each view only shows one day's worth of events. You can cycle through the different days of events by clicking on either the "Next" or "Prev" buttons.

## Installation

First you want to clone from git

```bash
git clone https://github.com/ronaldporch/event-calendar
```

Once the app has been downloaded go to the app's directory...

```bash
cd event-calendar
```

...then install all the gems for this app

```bash
bundle install
```

This assumes you already have the latest version of rails, ruby and postgres available. If this is not the case, take a look at [this helpful guide on how to get that.](https://gorails.com/setup/ubuntu/14.04)

Once the gems have been installed, the event and task models need to be migrated and the data be imported into the database. Let's go ahead and migrate our models.

```bash
rake db:migrate
```

After this, just call this custom rake task to import all the event and task data from the supplied CSV.

```bash
rake import:events
```

You should now be good to go. Let's start the rails server with

```bash
rails s
```

..and test out the app.

## Expectations
This app is expected to show all the events for the supplied tracks within a specific day. When visiting the main route the day is defaulted to the current day. You can go back until you find data to test out, but to help you out, the get query that has some actual test data will be ```?day=342&year=2015```.

Currently the times are displayed in 15-minute increments. This closely matches the times within the supplied CSV. In a future iteration, it's possible this could be scaled to be customizable.

The order of the Tracks can also be customized, although at the moment you would have to access the database to do so. Each track has an "order" column that can be modified to change the order they're displayed.

## Testing
This app also has a few tests just for some basic model logic. Once you've followed the steps of migrating the models and importing the CSV, these tests can be ran like so:

```bash
bundle exec rspec
```

Hopefully, all tests should pass if everything went well.

## Optimizations
Time.parse() and Time.between? proved to be the slowest piece of this. In a future iteration, there needs to be a better way to compare if an event is within a certain time increment that doesn't depend on parsing via Date or Time because that tends to be costly.

Heavier reliance on BDD will also help the application. Since the controllers and views are so simple in design, testing was passed.

As mentioned earlier, adding guis to edit the time increment and modify the order of the tracks would be a nice to have feature.

The index controller has not be configured to handle string values in the get query. Of course in a prod environment, this would be disastrous, but given the time, I guess this is okay. One benefit is that SQL Injection shouldn't be an issue.

As far as the relationship of Tasks and Events, I know it would be optimal to have a many-to-many relationship between the two, but with the way that I looped over them, I figured it would be okay to bypass this.

## Misc.

If you have any other questions about the app, shoot me an email that's listed on my github and I'll help out.

This app has only been tested in the development environment. Please configure your environment variables if you were to test this in production (Heroku, Digital Ocean, etc).