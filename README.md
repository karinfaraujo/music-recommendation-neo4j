# Music Recommendation System using Graph Database (Neo4j)

## 📌 Project Overview

This project demonstrates how to build a music recommendation system using a Graph Database.

Instead of traditional relational databases, graph databases focus on relationships, making them ideal for recommendation engines.

This project models users, songs, artists, and genres and uses graph algorithms to generate recommendations.

---

## 🚀 Technologies Used

* Neo4j AuraDB
* Cypher Query Language
* Graph Data Modeling
* Graph Data Science (GDS)
* Arrows.app (Graph Diagram)
* CSV Data Import

---

## 📊 Graph Data Model

### Nodes

* User
* Song
* Artist
* Genre

### Relationships

* LISTENED_TO
* BY_ARTIST
* IN_GENRE

Example:

(:User)-[:LISTENED_TO]->(:Song)

(:Song)-[:BY_ARTIST]->(:Artist)

(:Song)-[:IN_GENRE]->(:Genre)

(:Artist)-[:IN_GENRE]->(:Genre)

---

## 📥 Data Import (Cypher Script)

### Create Constraints

```cypher
CREATE CONSTRAINT user_id IF NOT EXISTS
FOR (u:User) REQUIRE u.userId IS UNIQUE;

CREATE CONSTRAINT song_id IF NOT EXISTS
FOR (s:Song) REQUIRE s.songId IS UNIQUE;

CREATE CONSTRAINT artist_id IF NOT EXISTS
FOR (a:Artist) REQUIRE a.artistId IS UNIQUE;

CREATE CONSTRAINT genre_id IF NOT EXISTS
FOR (g:Genre) REQUIRE g.genreId IS UNIQUE;
```

---

### Import Users

```cypher
LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
CREATE (:User {
userId: toInteger(row.userId),
name: row.name
});
```

---

### Import Artists

```cypher
LOAD CSV WITH HEADERS FROM 'file:///artists.csv' AS row
CREATE (:Artist {
artistId: toInteger(row.artistId),
name: row.name
});
```

---

### Import Genres

```cypher
LOAD CSV WITH HEADERS FROM 'file:///genres.csv' AS row
CREATE (:Genre {
genreId: toInteger(row.genreId),
name: row.name
});
```

---

### Import Songs

```cypher
LOAD CSV WITH HEADERS FROM 'file:///songs.csv' AS row
MATCH (a:Artist {artistId: toInteger(row.artistId)})
MATCH (g:Genre {genreId: toInteger(row.genreId)})
CREATE (s:Song {
songId: toInteger(row.songId),
title: row.title,
popularity: toInteger(row.popularity)
})
CREATE (s)-[:BY_ARTIST]->(a)
CREATE (s)-[:IN_GENRE]->(g);
```

---

### Import Listen Relationships

```cypher
LOAD CSV WITH HEADERS FROM 'file:///listens.csv' AS row
MATCH (u:User {userId: toInteger(row.userId)})
MATCH (s:Song {songId: toInteger(row.songId)})
CREATE (u)-[:LISTENED_TO {
playCount: toInteger(row.playCount)
}]->(s);
```

---

## 🔎 Basic Queries

### Most Popular Songs

```cypher
MATCH (s:Song)<-[l:LISTENED_TO]-()
RETURN s.title, COUNT(l) AS listens
ORDER BY listens DESC
LIMIT 10;
```

---

### Recommend Songs Based on Genre

```cypher
MATCH (u:User {userId: 1})-[:LISTENED_TO]->(s:Song)-[:IN_GENRE]->(g:Genre)
MATCH (rec:Song)-[:IN_GENRE]->(g)
WHERE NOT (u)-[:LISTENED_TO]->(rec)
RETURN rec.title
LIMIT 10;
```

---

## 🧠 Graph Data Science

### PageRank Algorithm

Find most influential songs:

```cypher
CALL gds.pageRank.stream({
nodeProjection: 'Song',
relationshipProjection: {
LISTENED_TO: {
type: 'LISTENED_TO',
orientation: 'REVERSE'
}
}
})
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).title AS song, score
ORDER BY score DESC
LIMIT 10;
```

---

## 📈 Skills Demonstrated

Graph Databases

Data Modeling

Recommendation Systems

Cypher Query Language

Graph Algorithms

Neo4j AuraDB

---

## 📌 Why Graph Database?

Graph databases allow faster and more accurate recommendations by analyzing relationships between users and content.

This is the same approach used by:

Netflix

Spotify

Amazon

---

## 👤 Author

Karin Araujo

Aspiring Data Analyst

Brazil

---

## ⭐ Portfolio Project

This project is part of my Data Analytics portfolio.
