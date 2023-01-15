# Good Night app

We would like you to implement a "good night" application to let users track when do they go to bed and when do they wake up.

We require some RESTful APIs to achieve the following:
- [x] Clock In operation.
    - [x] Go to bed.
      > GET /user/:user_id/go_to_bed
    - [x] Wake up.
      > GET /user/:user_id/wake_up
- [x] Return all clocked-in times, ordered by created time.
> GET /user/:user_id/sleeps
- [x] Users can follow and unfollow other users.
> GET /user/:user_id/follow/:friend_id

> GET /user/:user_id/unfollow/:friend_id
- [x] See the sleep records over the past week for their friends, ordered by the length of their sleep.
> GET /user/:user_id/friends

Please implement the model, db migrations, and JSON API.
You can assume that there are only two fields on the users "id" and "name".

You do not need to implement any user registration API.

Project spec:

* Ruby version 3.2.0 & Rails 7.0.4

I choose lastest verison bcause it's generally faster and securer.

* Install RSpec as test framework.

## Installation
1. Clone the repo from github.
   ```sh
   git clone https://github.com/bater/good_night.git
   ```
2. `cd good_night`
3. `bundle install`, please confirm the local ruby and rails version.
4. `rails db:setup`, create tables and loads the seeds.
5. `rails server`
6. Visit browser [http://localhost:3000/user/1/sleeps](http://localhost:3000/user/1/sleeps) for user 1 sleep records, ordered by created time.
7. Visit browser [http://localhost:3000/user/1/friends](http://localhost:3000/user/1/friends) to see the sleep records over the past week for user's friends, ordered by the length of their sleep.
8. Unfollow user 2 [http://localhost:3000/user/1/unfollow/2](http://localhost:3000/user/1/unfollow/2).
9. Follow user 2 [http://localhost:3000/user/1/follow/2](http://localhost:3000/user/1/follow/2).