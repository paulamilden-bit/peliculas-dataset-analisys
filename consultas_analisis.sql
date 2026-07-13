-- ============================================================
-- ANÁLISIS DE DATASET DE PELÍCULAS
-- Consultas SQL con preguntas de negocio e insights
-- Autora: Paula Milden
-- ============================================================

-- 1) TOP 5 películas por recaudación total
-- Objetivo: identificar los mayores éxitos de taquilla del dataset
SELECT titulo, recaudacion
FROM peliculas
WHERE recaudacion IS NOT NULL
ORDER BY recaudacion DESC
LIMIT 5;
-- Insight: Avatar y Avengers: Endgame lideran, ambas superando los 2.700 millones de dólares.


-- 2) Top 5 actores con más apariciones en el dataset
-- Objetivo: ver qué actores tienen mayor presencia en el catálogo analizado
SELECT actor, COUNT(*) AS apariciones
FROM peliculas_actores
GROUP BY actor
ORDER BY apariciones DESC
LIMIT 5;
-- Insight: el elenco de Harry Potter (Daniel Radcliffe, Emma Watson, Rupert Grint)
-- domina el ranking con 17 apariciones cada uno, reflejo de la saga completa en el dataset.


-- 3) Score promedio por género (entre los géneros con más películas)
-- Objetivo: entender qué géneros tienden a puntuar mejor
SELECT genero, ROUND(AVG(score), 1) AS score_promedio, COUNT(*) AS cantidad
FROM peliculas
WHERE score > 0
GROUP BY genero
ORDER BY cantidad DESC
LIMIT 5;
-- Insight: "Adventure, Fantasy" tiene el promedio más alto (78.2) entre los géneros más frecuentes.


-- 4) Películas con mayor ganancia neta (recaudación - presupuesto)
-- Objetivo: identificar las producciones más rentables, no solo las de mayor recaudación bruta
SELECT titulo, presupuesto, recaudacion, (recaudacion - presupuesto) AS ganancia
FROM peliculas
WHERE presupuesto IS NOT NULL AND recaudacion IS NOT NULL
ORDER BY ganancia DESC
LIMIT 5;
-- Insight: Avatar generó una ganancia neta de ~2.686 millones, la mayor del dataset.


-- 5) Cantidad de películas por país de origen
-- Objetivo: entender la composición geográfica del dataset
SELECT pais, COUNT(*) AS cantidad
FROM peliculas
GROUP BY pais
ORDER BY cantidad DESC
LIMIT 5;
-- Insight: la mayoría de los registros están marcados como "AU", seguido de "US",
-- lo que sugiere revisar la calidad de este campo en el dataset original (posible sesgo de origen de datos).


-- 6) Evolución de la cantidad de películas por década
-- Objetivo: ver cómo está distribuido el dataset en el tiempo
SELECT (CAST(SUBSTR(fecha, 7, 4) AS INTEGER) / 10) * 10 AS decada, COUNT(*) AS cantidad
FROM peliculas
WHERE fecha IS NOT NULL
GROUP BY decada
ORDER BY decada;
-- Insight: el dataset está fuertemente concentrado en películas de 2020 en adelante (293 de ~485),
-- por lo que los análisis reflejan mayormente producciones recientes.
