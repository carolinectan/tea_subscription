# TEA SUBSCRIPTION

Tea Subscription is a Rails only API application, with endpoints to subscribe a customer to a tea subscription, to cancel a customer's tea subscription, and to see all of a customer's subscriptions (active and cancelled).

## Version
- Rails 5.2.6
- Ruby 2.7.2

## System dependencies
- RSpec

## Configuration
```
git clone <ssh>
bundle
```

## Database creation
```
rails db:{create,migrate,seed}
```

## How to run the test suite
```
bundle exec rspec
```

<!-- ## Services (job queues, cache servers, search engines, etc.) -->
<!-- ## Deployment instructions -->

## Visual Database Schema
![Screen Shot 2021-11-08 at 6 59 19 PM](https://user-images.githubusercontent.com/81220681/140837165-3893bc9c-10cd-42df-90bf-a24fedea527f.png)

## Requests and Responses

### Get All Customers
```
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
GET http://localhost:3000/api/v1/customers
```

```
{
    "data": [
        {
            "id": "16",
            "type": "customer",
            "attributes": {
                "first_name": "Amanda",
                "last_name": "Hodkiewicz",
                "email": "gregg.leffler@powlowski-sanford.net",
                "address": "242 Becky Path, Wisozkbury, Alabama 20334-7435"
            }
        },
        {
            "id": "17",
            "type": "customer",
            "attributes": {
                "first_name": "Jacob",
                "last_name": "Gottlieb",
                "email": "lavera.stehr@shields-lubowitz.net",
                "address": "89153 Booker Station, East Kendrahaven, Georgia 65402-3589"
            }
        },
        ...
    ]
}
```

### Get One Customer
Append customer ID to end of URI
```
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
GET http://localhost:3000/api/v1/customers/16
```

```
{
    "data": {
        "id": "16",
        "type": "customer",
        "attributes": {
            "first_name": "Amanda",
            "last_name": "Hodkiewicz",
            "email": "gregg.leffler@powlowski-sanford.net",
            "address": "242 Becky Path, Wisozkbury, Alabama 20334-7435"
        }
    }
}
```

### Get One Customer's Subscriptions
```
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
GET http://localhost:3000/api/v1/customers/17/subscriptions
```

```
{
    "data": [
        {
            "id": "2",
            "type": "customer_subscriptions",
            "attributes": {
                "customer_id": 17,
                "tea_id": 2,
                "title": "infographic",
                "price": "11.99",
                "status": "active",
                "frequency": "monthly",
                "created_at": "2021-11-10T05:37:51.663Z",
                "updated_at": "2021-11-10T05:37:51.663Z"
            }
        },
        {
            "id": "3",
            "type": "customer_subscriptions",
            "attributes": {
                "customer_id": 17,
                "tea_id": 3,
                "title": "customer journey",
                "price": "15.99",
                "status": "active",
                "frequency": "monthly",
                "created_at": "2021-11-10T05:37:51.665Z",
                "updated_at": "2021-11-10T05:37:51.665Z"
            }
        }
    ]
}
```

### Create a Subscription for a Customer
```
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
# a subscription's default status is "active"
request_body = {
    "customer_id": customer1.id,
    "tea_id": tea1.id,
    "title": "Sleepy Time",
    "price": "6.99",
    "frequency": "monthly",
}
post "/api/v1/customers/#{customer1.id}/subscriptions"
```

```
{
    "data": {
        "id": "8",
        "type": "subscription",
        "attributes": {
            "customer_id": 16,
            "tea_id": 2,
            "title": "Sleepy Time",
            "price": "6.99",
            "status": "active",
            "frequency": "monthly",
            "created_at": "2021-11-12T00:53:37.952Z",
            "updated_at": "2021-11-12T00:53:37.952Z"
        }
    }
}
```

### Cancel a Customer's Subscription
```
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
request_body = {
  "customer_id": 16,
  "tea_id": 2,
  "status": 'cancelled'
}
patch "/api/v1/customers/#{customer1.id}/subscriptions/#{Subscription.last.id}"
```

```
{
    "data": {
        "id": "8",
        "type": "subscription",
        "attributes": {
            "customer_id": 16,
            "tea_id": 2,
            "title": "Sleepy Time",
            "price": "6.99",
            "status": "cancelled",
            "frequency": "monthly",
            "created_at": "2021-11-12T00:53:37.952Z",
            "updated_at": "2021-11-12T04:33:07.233Z"
        }
    }
}
```
