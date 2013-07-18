SELECT 	(s.cant + l.cant) AS cant_total, 
			s.cant, 
			l.cant, 
			date_format(s.salida, '%m %y') AS salida, 
			date_format(l.llegada, '%m %y') AS llegada,
			s.id_a,
			l.id_a
			
	FROM 	(
			SELECT 	COUNT(*) AS cant, 
					salida, 
					id_a 

			FROM	(
						SELECT 	u.id_user,
								s.salida,
								s.llegada,
								a.id_a

						FROM 	Aeropuerto a,
								Vuelo v,
								Servicio s,
								Tiene t,
								Reserva r,
								Hace h,
								Usuario u

						WHERE v.a_salida = a.id_a
						AND s.id_vuelo = v.id_vuelo
						AND t.id_serv = s.id_servicio
						AND r.id_reserva = t.id_res
						AND h.id_reserva = r.id_reserva
						AND u.id_user = h.id_user
					) us_por_a

			GROUP BY MONTH(salida), YEAR(salida), id_a
			HAVING 	date_format(salida, '%m %y') between '06 13' AND '08 13'
			)  s,

			(
			SELECT 	COUNT(*) AS cant, 
					llegada, 
					id_a 

			FROM	(
						SELECT 	u.id_user,
								s.salida,
								s.llegada,
								a.id_a

						FROM 	Aeropuerto a,
								Vuelo v,
								Servicio s,
								Tiene t,
								Reserva r,
								Hace h,
								Usuario u

						WHERE v.a_salida = a.id_a
						AND s.id_vuelo = v.id_vuelo
						AND t.id_serv = s.id_servicio
						AND r.id_reserva = t.id_res
						AND h.id_reserva = r.id_reserva
						AND u.id_user = h.id_user
					) us_por_a

			GROUP BY MONTH(llegada), YEAR(llegada), id_a
			HAVING 	date_format(llegada, '%m %y') between '06 13' AND '08 13'
			)  l


ORDER BY cant_total
