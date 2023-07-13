# README

Run `bundle install`

Run `rails s` to start server on http://localhost:3000/

Post readings via HTTP POST requests to `/readings?device_id={device_id}`

I ran out of time to implement tests. I think it may have made more sense to structure the API as `/devices/:id/readings` but given the time limit and that requirements center on the readings, I chose the current structure. Because I generated a Rails project for this, there are some unnecessary files that I would clean up if I had more time.
