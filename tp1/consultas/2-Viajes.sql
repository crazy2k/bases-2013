SELECT	COUNT(u.id_user) AS cant_pasajeros, DATE_FORMAT(s.salida,'%m %y') AS salida, DATE_FORMAT(s.llegada,'%m %y') AS llegada, a.nombre AS aeropuerto
FROM Aeropuerto a, Usuario u, Servicio s, Tiene t, Reserva r, Vuelo v, Hace h
WHERE (a.id_a = v.a_salida OR a.id_a = v.a_llegada)
	AND s.id_vuelo = v.id_vuelo
	AND t.id_serv = s.id_servicio
	AND r.id_reserva = t.id_res
	AND h.id_reserva = r.id_reserva
	AND u.id_user = h.id_user
GROUP BY a.id_a,MONTH(s.salida), YEAR(s.salida), MONTH(s.llegada), YEAR(s.llegada)
HAVING (salida BETWEEN '06 13' AND '08 13') AND (llegada BETWEEN '06 13' AND '08 13')
ORDER BY cant_pasajeros
