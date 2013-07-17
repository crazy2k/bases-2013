/*Cambiar el select* por delete, es solo para probar*/
select * 
from Reserva r1
where exists(
	select *, MIN(b.precio)
	from Reserva r2, Tiene t, Servicio s, Hace h, Usuario u, Vuelo v, Brinda b
	where t.id_res = r2.id_reserva
	and t.id_serv = s.id_servicio
	and h.id_reserva = r2.id_reserva
	and h.id_user = u.id_user
	and s.id_vuelo = v.id_vuelo	
/* Hasta aca tenemos las reservas del usuario */
	
/* Iguales fechas */
	and s.salida IN (
		select s2.salida
		from Servicio s2, Tiene t2	
		where s2.id_servicio = t2.id_serv 
		and t2.id_res = r1.id_reserva)

	and s.llegada IN ( 
		select s3.llegada
		from Servicio s3, Tiene t3	
		where s3.id_servicio = t3.id_serv 
		and t3.id_res = r1.id_reserva)

/* Iguales aeropuerto */
	and v.a_salida IN ( 
		select v4.a_salida
		from Servicio s4, Tiene t4, Vuelo v4
		where s4.id_servicio = t4.id_serv 
		and t4.id_res = r1.id_reserva
		and s4.id_vuelo = v4.id_vuelo)

	and v.a_llegada IN ( 
		select v5.a_llegada
		from Servicio s5, Tiene t5, Vuelo v5
		where s5.id_servicio = t5.id_serv
		and t5.id_res = r1.id_reserva
		and s5.id_vuelo = v5.id_vuelo)		
)
