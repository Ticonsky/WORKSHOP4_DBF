--Made by ticonsky :3 


-- Extensión para generar UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS user (
    id_user UUID PRIMARY KEY DEFAULT uuid_generate_v4(),  -- Clave primaria (UUID)
    name VARCHAR(50) NOT NULL,  -- Nombre del usuario
    email VARCHAR(30) UNIQUE,  -- Email único
    phone VARCHAR(50),  -- Teléfono
    nickname VARCHAR(20) UNIQUE NOT NULL,  -- Apodo único
    password VARCHAR(30) NOT NULL,  -- Contraseña
    fk_music_genre INT,  -- Clave foránea referenciando a musicalGenre
    fk_country INT,  -- Clave foránea referenciando a country
    FOREIGN KEY (fk_country) REFERENCES country(id_country)
);

-- Crear al menos 10 usuarios con nicknames diferentes y claves diferentes
INSERT INTO user (name, email, phone, nickname, password, fk_country) VALUES 
('Usuario 1', 'usuario1@example.com', '123456789', 'usuario1', '123456', 1),
('Usuario 2', 'usuario2@example.com', '123456789', 'usuario2', '123456', 2),
('Usuario 3', 'usuario3@example.com', '123456789', 'usuario3', '123456', 3),
('Usuario 4', 'usuario4@example.com', '123456789', 'usuario4', '123456', 4),
('Usuario 5', 'usuario5@example.com', '123456789', 'usuario5', '123456', 5),
('Usuario 6', 'usuario6@example.com', '123456789', 'usuario6', '123456', 1),
('Usuario 7', 'usuario7@example.com', '123456789', 'usuario7', '123456', 2),
('Usuario 8', 'usuario8@example.com', '123456789', 'usuario8', '123456', 3),
('Usuario 9', 'usuario9@example.com', '123456789', 'usuario9', '123456', 4),
('Usuario 10', 'usuario10@example.com', '123456789', 'usuario10', '123456', 5);

-- Tabla de Países
CREATE TABLE IF NOT EXISTS country (
    id_country SERIAL PRIMARY KEY,  -- Clave primaria
    name VARCHAR(25) UNIQUE NOT NULL  -- Nombre único del país
);

-- Crear al menos 5 países
INSERT INTO country (name) VALUES ('País 1'), ('País 2'), ('País 3'), ('País 4'), ('País 5');

-- Tabla de Géneros Musicales
CREATE TABLE IF NOT EXISTS musicalGenre (
    id_genre SERIAL PRIMARY KEY,  -- Clave primaria
    name VARCHAR(15) NOT NULL,  -- Nombre del género
    description VARCHAR(100)  -- Descripción del género
);

-- Crear al menos 5 géneros musicales
INSERT INTO musicalGenre (name, description) VALUES 
('Género 1', 'Descripción del género 1'), 
('Género 2', 'Descripción del género 2'),
('Género 3', 'Descripción del género 3'),
('Género 4', 'Descripción del género 4'),
('Género 5', 'Descripción del género 5');

-- Tabla de Cuentas Bancarias
CREATE TABLE IF NOT EXISTS bankaccount (
    id_bankaccount SERIAL PRIMARY KEY,  -- Clave primaria
    bank_name VARCHAR(50) NOT NULL,  -- Nombre del banco
    account_number VARCHAR(20) UNIQUE NOT NULL,  -- Número de cuenta único
    fk_country INT,  -- Clave foránea referenciando a country
    FOREIGN KEY (fk_country) REFERENCES country(id_country),
    fk_user UUID,  -- Clave foránea referenciando a user
    FOREIGN KEY (fk_user) REFERENCES user(id_user)
);

-- Crear al menos 5 cuentas bancarias
INSERT INTO bankaccount (bank_name, account_number, fk_country, fk_user) VALUES 
('Banco 1', '1234567890', 1, '0db3778a-fdb1-4ddd-94ae-6aa4471cbebc'),
('Banco 2', '0987654321', 2, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Banco 3', '1122334455', 3, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Banco 4', '5566778899', 4, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Banco 5', '9988776655', 5, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b');

-- Tabla de Canales
CREATE TABLE IF NOT EXISTS channel (
    id_channel SERIAL PRIMARY KEY,  -- Clave primaria
    name VARCHAR(30) NOT NULL,  -- Nombre del canal
    description VARCHAR(200),  -- Descripción del canal
    user_fk UUID,  -- Clave foránea referenciando a user
    FOREIGN KEY (user_fk) REFERENCES user(id_user)
);

-- Crear al menos 5 canales
INSERT INTO channel (name, description, user_fk) VALUES 
('Canal 1', 'Descripción del canal 1', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Canal 2', 'Descripción del canal 2', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Canal 3', 'Descripción del canal 3', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Canal 4', 'Descripción del canal 4', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Canal 5', 'Descripción del canal 5', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b');

-- Tabla de Videos
CREATE TABLE IF NOT EXISTS video (
    id_videos SERIAL PRIMARY KEY,  -- Clave primaria
    name VARCHAR(100) NOT NULL,  -- Nombre del video
    description VARCHAR(200),  -- Descripción del video
    date_upload INT NOT NULL,  -- Fecha de subida
    likes INT DEFAULT 0,  -- Número de likes
    dislikes INT DEFAULT 0,  -- Número de dislikes
    popular BOOLEAN DEFAULT FALSE,  -- Indica si el video es popular
    user_fk UUID,  -- Clave foránea referenciando a user
    FOREIGN KEY (user_fk) REFERENCES user(id_user),
    fk_genre INT,  -- Clave foránea referenciando a musicalGenre
    FOREIGN KEY (fk_genre) REFERENCES musicalGenre(id_genre),
    fk_channel INT,  -- Clave foránea referenciando a channel
    FOREIGN KEY (fk_channel) REFERENCES channel(id_channel)
);

-- Crear al menos 10 videos
INSERT INTO video (name, description, date_upload, user_fk, fk_genre, fk_channel) VALUES 
('Video 1', 'Descripción del video 1', 1630000000, '0db3778a-fdb1-4ddd-94ae-6aa4471cbebc', 1, 1),
('Video 2', 'Descripción del video 2', 1630000000, '0db3778a-fdb1-4ddd-94ae-6aa4471cbebc', 2, 2),
('Video 3', 'Descripción del video 3', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 3, 3),
('Video 4', 'Descripción del video 4', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 4, 4),
('Video 5', 'Descripción del video 5', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 5, 5),
('Video 6', 'Descripción del video 6', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 1, 1),
('Video 7', 'Descripción del video 7', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 2, 2),
('Video 8', 'Descripción del video 8', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 3, 3),
('Video 9', 'Descripción del video 9', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 4, 4),
('Video 10', 'Descripción del video 10', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 5, 5);

-- Tabla de Comentarios
CREATE TABLE IF NOT EXISTS comment (
    id_comment SERIAL PRIMARY KEY,  -- Clave primaria
    content VARCHAR(300) NOT NULL,  -- Contenido del comentario
    date_creation INT NOT NULL,  -- Fecha de creación
    likes INT DEFAULT 0,  -- Número de likes
    dislikes INT DEFAULT 0,  -- Número de dislikes
    user_fk UUID,  -- Clave foránea referenciando a user
    FOREIGN KEY (user_fk) REFERENCES user(id_user),
    video_fk INT,  -- Clave foránea referenciando a video
    FOREIGN KEY (video_fk) REFERENCES video(id_videos)
);

-- Crear al menos 5 comentarios
INSERT INTO comment (content, date_creation, user_fk, video_fk) VALUES 
('Comentario 1', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 1),
('Comentario 2', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 2),
('Comentario 3', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 3),
('Comentario 4', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 4),
('Comentario 5', 1630000000, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 5);

-- Tabla de Playlists
CREATE TABLE IF NOT EXISTS playlist (
    id_playlist SERIAL PRIMARY KEY,  -- Clave primaria
    name VARCHAR(30) NOT NULL,  -- Nombre de la playlist
    likes INT DEFAULT 0,  -- Número de likes
    user_fk UUID,  -- Clave foránea referenciando a user
    FOREIGN KEY (user_fk) REFERENCES user(id_user)
);

-- Crear al menos 5 playlists
INSERT INTO playlist (name, user_fk) VALUES 
('Playlist 1', '0db3778a-fdb1-4ddd-94ae-6aa4471cbebc'),
('Playlist 2', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Playlist 3', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Playlist 4', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
('Playlist 5', 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b');

-- Tabla de Comunidades
CREATE TABLE IF NOT EXISTS community (
    id_community SERIAL PRIMARY KEY,  -- Clave primaria
    name VARCHAR(25) UNIQUE NOT NULL,  -- Nombre único de la comunidad
    description VARCHAR(200)  -- Descripción
);

-- Crear al menos 5 comunidades
INSERT INTO community (name, description) VALUES 
('Comunidad 1', 'Descripción de la comunidad 1'),
('Comunidad 2', 'Descripción de la comunidad 2'),
('Comunidad 3', 'Descripción de la comunidad 3'),
('Comunidad 4', 'Descripción de la comunidad 4'),
('Comunidad 5', 'Descripción de la comunidad 5');

-- Tabla Relacional Playlist-Video
CREATE TABLE IF NOT EXISTS playlist_video_rel (
    playlist_fk INT,  -- Clave foránea referenciando a playlist
    video_fk INT,  -- Clave foránea referenciando a video
    PRIMARY KEY (playlist_fk, video_fk),  -- Clave primaria compuesta
    FOREIGN KEY (playlist_fk) REFERENCES playlist(id_playlist),
    FOREIGN KEY (video_fk) REFERENCES video(id_videos)
);

-- Crear al menos 5 relaciones entre playlists y videos
INSERT INTO playlist_video_rel (playlist_fk, video_fk) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Tabla Relacional Comunidad-Usuario
CREATE TABLE IF NOT EXISTS community_user_rel (
    community_fk INT,  -- Clave foránea referenciando a community
    user_fk UUID,  -- Clave foránea referenciando a user
    PRIMARY KEY (community_fk, user_fk),  -- Clave primaria compuesta
    FOREIGN KEY (community_fk) REFERENCES community(id_community),
    FOREIGN KEY (user_fk) REFERENCES user(id_user)
);

-- Crear al menos 5 relaciones entre comunidades y usuarios
INSERT INTO community_user_rel (community_fk, user_fk) VALUES 
(1, '0db3778a-fdb1-4ddd-94ae-6aa4471cbebc'),
(2, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
(3, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
(4, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b'),
(5, 'f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b');

-- Tabla Relacional Suscriptor
CREATE TABLE IF NOT EXISTS subscriber_rel (
    user_fk UUID,  -- Clave foránea referenciando a user
    channel_fk INT,  -- Clave foránea referenciando a channel
    payed BOOLEAN DEFAULT false,  -- Indicador de pago
    pay_cost FLOAT,  -- Costo de suscripción
    date_subscribed INT NOT NULL,  -- Fecha de suscripción
    PRIMARY KEY (user_fk, channel_fk),  -- Clave primaria compuesta
    FOREIGN KEY (user_fk) REFERENCES user(id_user),
    FOREIGN KEY (channel_fk) REFERENCES channel(id_channel)
);

-- Crear al menos 5 relaciones de suscripción
INSERT INTO subscriber_rel (user_fk, channel_fk, payed, pay_cost, date_subscribed) VALUES 
('0db3778a-fdb1-4ddd-94ae-6aa4471cbebc', 1, true, 9.99, 1630000000),
('f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 2, false, 0.00, 1630000000),
('f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 3, true, 19.99, 1630000000),
('f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 4, false, 0.00, 1630000000),
('f47b3b3b-4b3b-4b3b-4b3b-4b3b4b3b4b3b', 5, true, 4.99, 1630000000);

-- 1. Todos los videos subidos por cualquier usuario de un país específico
-- Selecciona todos los videos subidos por usuarios de un país específico
SELECT v.*
FROM video v
-- Une la tabla video con la tabla user utilizando la clave foránea user_fk
JOIN user u ON v.user_fk = u.id_user
-- Une la tabla user con la tabla country utilizando la clave foránea fk_country
JOIN country c ON u.fk_country = c.id_country
WHERE c.name = 'nombre_del_pais';

-- 2. Mostrar los géneros musicales disponibles y contar cuántos videos hay por género
-- Selecciona los géneros musicales y cuenta cuántos videos hay por género
SELECT mg.name AS genre_name, COUNT(v.id_videos) AS video_count
FROM musicalGenre mg
-- Unión izquierda con la tabla video utilizando la clave foránea fk_genre
LEFT JOIN video v ON mg.id_genre = v.fk_genre
GROUP BY mg.name;

-- 3. Mostrar la información de todos los videos, añadiendo el nombre y el email del usuario que lo subió, con más de 20 likes
-- Selecciona la información de los videos con más de 20 likes, incluyendo el nombre y email del usuario que lo subió
SELECT v.*, u.name AS user_name, u.email
FROM video v
-- Une la tabla video con la tabla user utilizando la clave foránea user_fk
JOIN user u ON v.user_fk = u.id_user
WHERE v.likes > 20;

-- 4. Mostrar todos los canales que tienen al menos un suscriptor de un país específico
-- Selecciona todos los canales que tienen al menos un suscriptor de un país específico
SELECT DISTINCT ch.*
FROM channel ch
-- Une la tabla channel con la tabla subscriber_rel utilizando la clave foránea channel_fk
JOIN subscriber_rel sr ON ch.id_channel = sr.channel_fk
-- Une la tabla subscriber_rel con la tabla user utilizando la clave foránea user_fk
JOIN user u ON sr.user_fk = u.id_user
-- Une la tabla user con la tabla country utilizando la clave foránea fk_country
JOIN country c ON u.fk_country = c.id_country
WHERE c.name = 'nombre_del_pais';

-- 5. Mostrar todos los comentarios con la información relacionada del usuario y el video, donde el comentario tenga la palabra "ugly"
-- Selecciona todos los comentarios que contengan la palabra "ugly", incluyendo información del usuario y el video relacionados
SELECT c.*, u.name AS user_name, v.name AS video_name
FROM comment c
-- Une la tabla comment con la tabla user utilizando la clave foránea user_fk
JOIN user u ON c.user_fk = u.id_user
-- Une la tabla comment con la tabla video utilizando la clave foránea video_fk
JOIN video v ON c.video_fk = v.id_videos
WHERE c.content LIKE '%ugly%';

-- 6. Mostrar los primeros tres usuarios con toda la información relacionada para país, cuenta bancaria y género musical preferido, ordenados por email
-- Selecciona los primeros tres usuarios con información relacionada de país, cuenta bancaria y género musical preferido, ordenados por email
SELECT u.*, c.name AS country_name, ba.bank_name, ba.account_number, mg.name AS genre_name
FROM user u
-- Unión izquierda con la tabla country utilizando la clave foránea fk_country
LEFT JOIN country c ON u.fk_country = c.id_country
-- Unión izquierda con la tabla bankaccount utilizando la clave foránea fk_user
LEFT JOIN bankaccount ba ON u.id_user = ba.fk_user
-- Unión izquierda con la tabla musicalGenre utilizando la clave foránea fk_music_genre
LEFT JOIN musicalGenre mg ON u.fk_music_genre = mg.id_genre
ORDER BY u.email
LIMIT 3;

-- Añadir columna Popular a la tabla video
ALTER TABLE video ADD COLUMN popular BOOLEAN DEFAULT FALSE;

-- Actualizar la columna Popular para marcar videos con más de 20 likes como populares
UPDATE video
SET popular = TRUE
WHERE likes > 20;
