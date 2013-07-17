/*Cambiar el select* por delete, es solo para probar*/
select * 
from reserva r1
where exists(
	select *, MIN(b.precio)
	from reserva r2, tiene t, servicio s, hace h, usuario u, vuelo v, brinda b
	where t.nro_reserva = r2.nro_reserva
	and t.id_servicio = s.id_servicio
	and h.nro_reserva = r2.nro_reserva
	and h.id_user = u.id_user
	and s.id_vuelo = v.id_vuelo	
/* Hasta aca tenemos las reservas del usuario */
	
/* Iguales fechas */
	and s.fecha_salida IN (
		select s2.fecha_salida
		from servicio s2, tiene t2	
		where s2.id_servicio = t2.id_servicio 
		and t2.nro_reserva = r1.nro_reserva)

	and s.fecha_llegada IN ( 
		select s3.fecha_llegada
		from servicio s3, tiene t3	
		where s3.id_servicio = t3.id_servicio 
		and t3.nro_reserva = r1.nro_reserva)

/* Iguales aeropuerto */
	and v.aeropuerto_salida IN ( 
		select v4.aeropuerto_salida
		from servicio s4, tiene t4, vuelvo v4
		where s4.id_servicio = t4.id_servicio 
		and t4.nro_reserva = r1.nro_reserva
		and s4.id_vuelo = v4.id_vuelo)

	and v.aeropuerto_llegada IN ( 
		select v5.aeropuerto_llegada
		from servicio s5, tiene t5, vuelvo v5
		where s5.id_servicio = t5.id_servicio 
		and t5.nro_reserva = r1.nro_reserva
		and s5.id_vuelo = v5.id_vuelo)		
)
