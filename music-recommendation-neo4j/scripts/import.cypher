// CONSTRAINTS

CREATE CONSTRAINT user_id IF NOT EXISTS
FOR (u:User) REQUIRE u.userId IS UNIQUE;

CREATE CONSTRAINT song_id IF NOT EXISTS
FOR (s:Song) REQUIRE s.songId IS UNIQUE;

CREATE CONSTRAINT artist_id IF NOT EXISTS
FOR (a:Artist) REQUIRE a.artistId IS UNIQUE;

CREATE CONSTRAINT genre_id IF NOT EXISTS
FOR (g:Genre) REQUIRE g.genreId IS UNIQUE;


// USERS

LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
CREATE (:User {
userId: toInteger(row.userId),
name: row.name
});


// ARTISTS

LOAD CSV WITH HEADERS FROM 'file:///artists.csv' AS row
CREATE (:Artist {
artistId: toInteger(row.artistId),
name: row.name
});


// GENRES

LOAD CSV WITH HEADERS FROM 'file:///genres.csv' AS row
CREATE (:Genre {
genreId: toInteger(row.genreId),
name: row.name
});


// SONGS

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


// RELATIONSHIPS

LOAD CSV WITH HEADERS FROM 'file:///listens.csv' AS row
MATCH (u:User {userId: toInteger(row.userId)})
MATCH (s:Song {songId: toInteger(row.songId)})
CREATE (u)-[:LISTENED_TO {
playCount: toInteger(row.playCount)
}]->(s);