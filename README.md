[ ![Codeship Status for macbury/busix](https://app.codeship.com/projects/ca0af0d0-a30f-0136-e159-3a2d92578496/status?branch=master)](https://app.codeship.com/projects/307233)

# About

Scraps http://www.mpk.krakow.pl/pl/page-f3044045/ and expose public transport as graphql endpoint. 

# Demo

http://kraków.online/api/explorer

## Example Query:

```graphql
{
  departures(from: "Białucha", to: "Wzgórza Krzesławickie", at: "10 minutes from now"){
    line {
      name
      kind
    }
    
    time {
      formatted
      distance
    }
  }
}
```

## Example Response:

```json
{
  "data": {
    "departures": [
      {
        "line": {
          "name": "73",
          "kind": "tram"
        },
        "time": {
          "formatted": "22:36",
          "distance": "17 minutes from now"
        }
      },
      {
        "line": {
          "name": "5",
          "kind": "tram"
        },
        "time": {
          "formatted": "22:37",
          "distance": "18 minutes from now"
        }
      },
      {
        "line": {
          "name": "73",
          "kind": "tram"
        },
        "time": {
          "formatted": "22:51",
          "distance": "32 minutes from now"
        }
      },
      {
        "line": {
          "name": "5",
          "kind": "tram"
        },
        "time": {
          "formatted": "22:58",
          "distance": "39 minutes from now"
        }
      },
      {
        "line": {
          "name": "73",
          "kind": "tram"
        },
        "time": {
          "formatted": "23:06",
          "distance": "about 1 hour from now"
        }
      },
      {
        "line": {
          "name": "73",
          "kind": "tram"
        },
        "time": {
          "formatted": "23:20",
          "distance": "about 1 hour from now"
        }
      },
      {
        "line": {
          "name": "5",
          "kind": "tram"
        },
        "time": {
          "formatted": "23:21",
          "distance": "about 1 hour from now"
        }
      },
      {
        "line": {
          "name": "73",
          "kind": "tram"
        },
        "time": {
          "formatted": "23:31",
          "distance": "about 1 hour from now"
        }
      },
      {
        "line": {
          "name": "73",
          "kind": "tram"
        },
        "time": {
          "formatted": "23:46",
          "distance": "about 1 hour from now"
        }
      },
      {
        "line": {
          "name": "73",
          "kind": "tram"
        },
        "time": {
          "formatted": "23:59",
          "distance": "about 2 hours from now"
        }
      }
    ]
  }
}
```


# References
* https://krabok.wordpress.com/2017/04/17/sledzenie-tramwajow-na-zywo-z-ttss/
* http://monitoring.krakow.pios.gov.pl/
