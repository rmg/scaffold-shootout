# scaffold-shootout
A comparison of different web app scaffold generators

## Models

```
User:
  - name (string)
  - email (string)
Post:
  - title (text)
  - body (text)
  - author (User)
Comment:
  - body (text)
  - post (Post)
  - author (User)
```
