delete from reserva r1
where
exists
(
	select *
	from reserva r2, tiene t, servicio s, hace h, 
			usuario u, vuelvo v
	where t.nro_reserva = r2.nro_reserva
	and t.id_servicio = s.id_servicio
	and h.nro_reserva = r2.nro_reserva
	and h.id_user = u.id_user
	and s.asociadoA = v.nro_vuelo	
	/* Hasta aca tenemos las reservas del usuario */
	
	/* Iguales fechas */
	and s.fecha_salida = 
		(select s2.fecha_salida
		from servicio s2, tiene t2	
		where s2.id_servicio = t2.id_servicio 
		and t2.nro_reserva = r1.nro_reserva)

	and s.fecha_llega = 
		(select s2.fecha_llegada
		from servicio s2, tiene t2	
		where s2.id_servicio = t2.id_servicio 
		and t2.nro_reserva = r1.nro_reserva)

	/* Iguales aeropuerto */
	and v.saleDe = 
		(select v2.saleDe
		from servicio s2, tiene t2, vuelvo v2	
		where s2.id_servicio = t2.id_servicio 
		and t2.nro_reserva = r1.nro_reserva
		and s2.asociadoA = v2.nro_vuelo)

	and v.llegaA = 
		(select v2.llegaA
		from servicio s2, tiene t2, vuelvo v2	
		where s2.id_servicio = t2.id_servicio 
		and t2.nro_reserva = r1.nro_reserva
		and s2.asociadoA = v2.nro_vuelo)

	/* Fecha partida dentro de los próximos 7 días */
	and data_sub(s.fecha_salida, now()) < 7

	/* Menor precio */

	#and precio < precio2
)