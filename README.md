# Postgraphile example

## :hammer: Setup

To set this up, you'll have to do the following.

```
$ docker-compose run graphql bash
root@container_id:/app# ./db-reset.sh
root@container_id:/app# psql -h db -d reviews -U postgres -f seed.sql
```

This creates the database, roles, sets up the [schema](https://dreampuf.github.io/GraphvizOnline/#digraph%20G%20%7B%20%0A%20%20%20%20%2F%2F%20%20%0A%20%20%20%20%2F%2F%20Defaults%0A%20%20%20%20%2F%2F%20%20%0A%0A%20%20%20%20%2F%2F%20Box%20for%20entities%0A%20%20%20%20node%20%5Bshape%3Dnone%2C%20margin%3D0%5D%0A%0A%20%20%20%20%2F%2F%20One-to-many%20relation%20(from%20one%2C%20to%20many)%0A%20%20%20%20edge%20%5Barrowhead%3Dcrow%2C%20arrowtail%3Dnone%2C%20dir%3Dboth%5D%0A%0A%20%20%20%20%2F%2F%20%20%0A%20%20%20%20%2F%2F%20Entities%0A%20%20%20%20%2F%2F%20%20%0A%20%20%20%20Person%20%5Blabel%3D%3C%0A%20%20%20%20%20%20%20%20%3Ctable%20border%3D%220%22%20cellborder%3D%221%22%20cellspacing%3D%220%22%20cellpadding%3D%224%22%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%20bgcolor%3D%22lightblue%22%3EPerson%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eid%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%3C%2Ftable%3E%0A%20%20%20%20%3E%5D%0A%0A%20%20%20%20Profile%20%5Blabel%3D%3C%0A%20%20%20%20%20%20%20%20%3Ctable%20border%3D%220%22%20cellborder%3D%221%22%20cellspacing%3D%220%22%20cellpadding%3D%224%22%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%20bgcolor%3D%22lightblue%22%3EProfile%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eid%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eperson_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%3C%2Ftable%3E%0A%20%20%20%20%3E%5D%0A%20%20%20%20%0A%20%20%20%20Account%20%5Blabel%3D%3C%0A%20%20%20%20%20%20%20%20%3Ctable%20border%3D%220%22%20cellborder%3D%221%22%20cellspacing%3D%220%22%20cellpadding%3D%224%22%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%20bgcolor%3D%22%23ffeeee%22%3EAccount%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eperson_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%3C%2Ftable%3E%0A%20%20%20%20%3E%5D%0A%20%20%20%20%0A%20%20%20%20Dish%20%5Blabel%3D%3C%0A%20%20%20%20%20%20%20%20%3Ctable%20border%3D%220%22%20cellborder%3D%221%22%20cellspacing%3D%220%22%20cellpadding%3D%224%22%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%20bgcolor%3D%22lightblue%22%3EDish%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eid%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%3C%2Ftable%3E%0A%20%20%20%20%3E%5D%0A%20%20%20%20%0A%20%20%20%20Menu%20%5Blabel%3D%3C%0A%20%20%20%20%20%20%20%20%3Ctable%20border%3D%220%22%20cellborder%3D%221%22%20cellspacing%3D%220%22%20cellpadding%3D%224%22%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%20bgcolor%3D%22lightblue%22%3EMenu%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eid%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Edish_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Erestaurant_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eprice%3A%20numeric%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%3C%2Ftable%3E%0A%20%20%20%20%3E%5D%0A%20%20%20%20%0A%20%20%20%20Restaurant%20%5Blabel%3D%3C%0A%20%20%20%20%20%20%20%20%3Ctable%20border%3D%220%22%20cellborder%3D%221%22%20cellspacing%3D%220%22%20cellpadding%3D%224%22%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%20bgcolor%3D%22lightblue%22%3ERestaurant%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eid%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eowner_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%3C%2Ftable%3E%0A%20%20%20%20%3E%5D%0A%20%20%20%20%0A%20%20%20%20Review%20%5Blabel%3D%3C%0A%20%20%20%20%20%20%20%20%3Ctable%20border%3D%220%22%20cellborder%3D%221%22%20cellspacing%3D%220%22%20cellpadding%3D%224%22%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%20bgcolor%3D%22lightblue%22%3EReview%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eid%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eperson_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Erestaurant_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%3C%2Ftable%3E%0A%20%20%20%20%3E%5D%0A%20%20%20%20%0A%20%20%20%20ReviewDish%20%5Blabel%3D%3C%0A%20%20%20%20%20%20%20%20%3Ctable%20border%3D%220%22%20cellborder%3D%221%22%20cellspacing%3D%220%22%20cellpadding%3D%224%22%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%20bgcolor%3D%22lightblue%22%3EReviewDish%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Eid%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Ereview_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%20%20%20%20%3Ctr%3E%3Ctd%3Emenu_id%3A%20bigint%3C%2Ftd%3E%3C%2Ftr%3E%0A%20%20%20%20%20%20%20%20%3C%2Ftable%3E%0A%20%20%20%20%3E%5D%0A%0A%20%20%20%20%2F%2F%20%20%0A%20%20%20%20%2F%2F%20Relationships%0A%20%20%20%20%2F%2F%20%20%0A%20%20%20%20edge%20%5Barrowhead%3Dnone%2C%20arrowtail%3Dnone%2C%20dir%3Dboth%5D%0A%20%20%20%20Person-%3EAccount%3B%0A%20%20%20%20Person-%3EProfile%3B%0A%20%20%20%20%0A%20%20%20%20edge%20%5Barrowhead%3Dcrow%2C%20arrowtail%3Dnone%2C%20dir%3Dboth%5D%0A%20%20%20%20Person-%3EReview%3B%0A%20%20%20%20Person-%3ERestaurant%3B%0A%20%20%20%20Restaurant-%3EReview%3B%0A%20%20%20%20Review-%3EReviewDish%3B%0A%20%20%20%20ReviewDish-%3EMenu%3B%0A%20%20%20%20Restaurant-%3EMenu%3B%0A%20%20%20%20Menu-%3EDish%3B%0A%7D) and also inserts some seed data. 

## :rocket: Running

You can then start the GraphQL server with the following command.

```
$ docker-compose up graphql
```

You can now visit the graphiql interface at [http://localhost:3000](http://localhost:3000).

All this without writing a single like of JavaScript :monkey:.
