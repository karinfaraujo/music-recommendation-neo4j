# 🎧 Music Recommendation System using Neo4j Graph Database

![Project Preview](https://github.com/karinfaraujo/music-recommendation-neo4j/blob/main/music-recommendation-neo4j/images/graph.png?raw=true)

---

## 📌 Overview

This project demonstrates how to build a Music Recommendation System using a Graph Database.

Graph databases focus on relationships between entities, making them ideal for recommendation engines like those used by Spotify and Netflix.

The system models users, songs, artists, and genres as nodes and their interactions as relationships.

Using Cypher queries, it is possible to analyze listening behavior and recommend new songs.

---

## 🚀 Technologies Used

* Neo4j AuraDB
* Cypher Query Language
* Graph Data Modeling
* CSV Data Import
* Arrows.app (Graph Modeling)
* GitHub

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

---

## 📐 Graph Schema

(User)-[:LISTENED_TO]->(Song)

(Song)-[:BY_ARTIST]->(Artist)

(Song)-[:IN_GENRE]->(Genre)

---

## 📥 Data Import

Data was imported using Cypher LOAD CSV from public GitHub URLs.

Example:

```cypher
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/.../users.csv' AS row
CREATE (:User {
userId: toInteger(row.userId),
name: row.name
});
```

---

## 🔎 Example Queries

### Graph Visualization

```cypher
MATCH (u:User)-[r:LISTENED_TO]->(s:Song)
MATCH (s)-[r2:BY_ARTIST]->(a:Artist)
MATCH (s)-[r3:IN_GENRE]->(g:Genre)

RETURN u, r, s, r2, a, r3, g

LIMIT 50
```

---

### Most Popular Songs

```cypher
MATCH (s:Song)<-[r:LISTENED_TO]-()

RETURN
s.title AS song,
COUNT(r) AS total_listens

ORDER BY total_listens DESC

LIMIT 10
```

---

### Song Recommendation Query

```cypher
MATCH (u:User {userId: 10})-[:LISTENED_TO]->(s:Song)-[:IN_GENRE]->(g:Genre)

MATCH (recommended:Song)-[:IN_GENRE]->(g)

WHERE NOT (u)-[:LISTENED_TO]->(recommended)

RETURN recommended.title AS recommendation

LIMIT 10
```

---

## 📈 Skills Demonstrated

Graph Database Modeling

Cypher Query Language

Recommendation Systems

Data Analysis

Data Import and Transformation

Graph Visualization

---

## 🎯 Project Goal

The goal of this project is to demonstrate how graph databases can be used to build recommendation systems based on relationships between users and content.

---

## 📷 Screenshots

See images folder for graph visualization and query results.

---

## 👤 Author

Karin Araujo

Aspiring Data Analyst

Brazil

GitHub: https://github.com/karinfaraujo

LinkedIn: [www.linkedin.com/in/karinfaraujo](http://www.linkedin.com/in/karinfaraujo)

---

## ⭐ Portfolio Project

This project is part of my Data Analytics portfolio.
