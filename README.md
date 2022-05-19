# README

[Live at Heroku](https://fridge.herokuapp.com/)

```bash
bundle install
yarn install
bin/dev
```

You may need to set these env vars :

```bash
export DATABASE_PORT=
export DATABASE_HOST=
export DATABASE_USER=
```

## A few things I (know|remember) I could have done better:

- made the choice to use the intersection on ingredients instead of the union
  - started with union and had a working algorithm
    - count for each recipe the number of ingredients that match the ingredients I have (score)
    - count the total number of ingredients for the recipe (max_score)
    - final scoring was something like max_score - (max_score - score)
    - I tried to apply some pondering too (something like "if the score is more than the half of max_score apply bonus, if the score is less than a third of the max_score apply a penalty")
- could have used a streamed JSON parser to handle huge file size
- could have normalized ingredients better
  - match some patterns (spoon, cup, numbers, etc)
  - place the quantity and unit in the association model
- could have paginated the endpoint
- the UI is… what it is :)
- could have better handled the Heroku's postgres addon row limit
  - ATM it's an env variable setting the limit
  - if you forget to set it it won't work (nil.to_i == 0)
- performances weren't something I worked on
