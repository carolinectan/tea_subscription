# 🍵🫖 TEA SUBSCRIPTION 🍵🫖
![pexels-esranur-kalay-7543665-2](https://user-images.githubusercontent.com/81220681/141414032-590976e3-dd70-4cd4-a8ba-aa2766ee01c6.jpg)

## Overview
Tea Subscription is a Rails only API application, with endpoints to subscribe a customer to a tea subscription, to cancel a customer's tea subscription, and to see all of a customer's subscriptions (active and cancelled).

## Table of Contents
<!-- - [Technologies and Design Principles](#technologies-and-design-principles) -->
- [Environment Setup](#environment-setup)
- [Configuration](#configuration)
- [Visual Database Schema](#visual-database-schema)
- [Database Creation](#database-creation)
- [How to Run the Test Suite](#how-to-run-the-test-suite)
- [How to Run the Server](#how-to-run-the-server)
- [Requests and Responses](#requests-and-responses)
    - [Get All Customers](#get-all-customers)
    - [Get a Customer](#get-a-customer)
    - [Get a Customer's Subscriptions](#get-a-customers-subscriptions)
    - [Create a Subscription](#create-a-subscription)
    - [Cancel a Subscription](#cancel-a-subscription)
- [Contributors](#contributors)

## Environment Setup
### Ruby 2.7.2
- Check your Ruby version `ruby -v`
- If your version is NOT Ruby 2.7.2, you can install Ruby 2.7.2 with `rbenv install 2.7.2`
- To set the Ruby version for a specific directory and all subdirectories within it,
```
cd <repo name>
rbenv local 2.7.2
```
- Double check that your Ruby version is correct after changing it with `ruby -v`
[Back to top](#overview)

### Rails 5.2.6
- [Rails](https://guides.rubyonrails.org/v5.0/getting_started.html) is a Gem, and if you are using rbenv, gems are specific to your current Ruby version, so you need to make sure you are on Ruby 2.7.2 before proceeding by following the instructions above.
- Check your Rails version `rails -v`
- If you get a message saying rails is not installed or you do not have version 5.2.5, run `gem install rails --version 5.2.5`.
- Double check that your Ruby version is correct after changing it with `rails -v`
[Back to top](#overview)

## Configuration
```
git clone <ssh>
cd <repo_name>
bundle
```
[Back to top](#overview)

## Visual Database Schema
![Screen Shot 2021-11-08 at 6 59 19 PM](https://user-images.githubusercontent.com/81220681/140837165-3893bc9c-10cd-42df-90bf-a24fedea527f.png)
[Back to top](#overview)

## Database Creation
```
rails db:{create,migrate,seed}
```
[Back to top](#overview)

## How to Run the Test Suite
```
bundle exec rspec
```
[Back to top](#overview)

## How to Run the Server
```
rails s
```
[Back to top](#overview)

## Requests and Responses
Base URL `http://localhost:3000`
Note: Run `rails s` to start your server.

### Get All Customers
```ruby
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }

GET '/api/v1/customers'
```

```json
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
[Back to top](#overview)

### Get a Customer
Append customer ID to end of URI
```ruby
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }

GET '/api/v1/customers/16'
```

```json
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
[Back to top](#overview)

### Get a Customer's Subscriptions
```ruby
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }

GET '/api/v1/customers/17/subscriptions'
```

```json
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
[Back to top](#overview)

### Create a Subscription
```ruby
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
# a subscription's default status is "active"
request_body = {
    "customer_id": 16,
    "tea_id": 2,
    "title": "Sleepy Time",
    "price": "6.99",
    "frequency": "monthly",
}

POST '/api/v1/customers/16/subscriptions'
```

```json
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
[Back to top](#overview)

### Cancel a Subscription
```ruby
headers = { CONTENT_TYPE: 'application/json', Accept: 'application/json' }
request_body = {
  "customer_id": 16,
  "tea_id": 2,
  "status": "cancelled"
}

PATCH '/api/v1/customers/#{customer1.id}/subscriptions/8'
```

```json
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
[Back to top](#overview)

## Contributors
🙋🏻‍♀ **Caroline Tan**
- Github: [Caroline Tan](https://github.com/carolinectan)
- LinkedIn: [Caroline Tan](https://www.linkedin.com/in/carolinectan/)
