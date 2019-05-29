[ ![Codeship Status for macbury/busix](https://app.codeship.com/projects/ca0af0d0-a30f-0136-e159-3a2d92578496/status?branch=master)](https://app.codeship.com/projects/307233)

# About

Scraps http://www.mpk.krakow.pl/pl/page-f3044045/ and expose public transport as graphql endpoint. 

# Demo

http://kraków.online/api/explorer

## Example Query:

```graphql
{
  departures(from: "Białucha", to: "Wzgórza Krzesławickie", at: "10 minutes from now"){
    edges {
      node {
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
  }
}
```

## Example Response:

```json
{
  "data": {
    "departures": {
      "edges": [
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "09:28",
              "distance": "10 minut from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "09:43",
              "distance": "25 minut from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "09:58",
              "distance": "40 minut from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "10:13",
              "distance": "około godziny from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "10:28",
              "distance": "około godziny from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "10:43",
              "distance": "około godziny from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "10:58",
              "distance": "około 2 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "11:13",
              "distance": "około 2 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "11:28",
              "distance": "około 2 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "11:43",
              "distance": "około 2 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "11:58",
              "distance": "około 3 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "12:13",
              "distance": "około 3 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "12:28",
              "distance": "około 3 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "12:43",
              "distance": "około 3 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "12:58",
              "distance": "około 4 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "13:14",
              "distance": "około 4 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "13:31",
              "distance": "około 4 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "13:46",
              "distance": "około 4 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "14:01",
              "distance": "około 5 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "14:16",
              "distance": "około 5 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "14:31",
              "distance": "około 5 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "14:46",
              "distance": "około 5 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "15:01",
              "distance": "około 6 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "15:16",
              "distance": "około 6 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "15:31",
              "distance": "około 6 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "15:46",
              "distance": "około 6 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "16:01",
              "distance": "około 7 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "16:16",
              "distance": "około 7 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "16:31",
              "distance": "około 7 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "16:46",
              "distance": "około 7 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "17:01",
              "distance": "około 8 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "17:16",
              "distance": "około 8 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "17:31",
              "distance": "około 8 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "17:46",
              "distance": "około 8 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "18:01",
              "distance": "około 9 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "18:16",
              "distance": "około 9 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "18:31",
              "distance": "około 9 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "18:46",
              "distance": "około 9 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "19:01",
              "distance": "około 10 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "19:15",
              "distance": "około 10 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "19:30",
              "distance": "około 10 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "19:45",
              "distance": "około 10 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "20:01",
              "distance": "około 11 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "20:16",
              "distance": "około 11 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "20:31",
              "distance": "około 11 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "20:47",
              "distance": "około 11 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "21:02",
              "distance": "około 12 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "21:17",
              "distance": "około 12 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "21:32",
              "distance": "około 12 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "21:50",
              "distance": "około 13 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "22:05",
              "distance": "około 13 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "22:20",
              "distance": "około 13 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "22:35",
              "distance": "około 13 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "22:50",
              "distance": "około 14 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "23:05",
              "distance": "około 14 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "23:16",
              "distance": "około 14 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "23:29",
              "distance": "około 14 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "23:44",
              "distance": "około 14 godzin from now"
            }
          }
        },
        {
          "node": {
            "line": {
              "name": "73",
              "kind": "tram"
            },
            "time": {
              "formatted": "23:59",
              "distance": "około 15 godzin from now"
            }
          }
        }
      ]
    }
  }
}
```


# References
* https://krabok.wordpress.com/2017/04/17/sledzenie-tramwajow-na-zywo-z-ttss/
* http://monitoring.krakow.pios.gov.pl/
