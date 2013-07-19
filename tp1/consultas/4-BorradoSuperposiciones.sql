delete
from Reserva r1
where r1.id_reserva IN (
	select r3.id_reserva
	from Reserva r3, Hace h3, Tiene t3, Servicio s3, Usuario u3, Vuelo v3, Brinda b
	where r3.id_reserva = h3.id_reserva
		and r3.id_reserva = t3.id_res
		and u3.id_user = h3.id_user
		and t3.id_serv = s3.id_servicio
		and s3.id_vuelo = v3.id_vuelo
		and s3.salida IN (
			select s4.salida
			from Servicio s4, Hace h4, Tiene t4, Reserva r4, Vuelo v4
			where r4.id_reserva <> r3.id_reserva
				and h4.id_reserva = r4.id_reserva
				and h4.id_user = h3.id_user
				and r4.id_reserva = t4.id_res
				and t4.id_serv = s4.id_servicio
				and s4.id_vuelo = v4.id_vuelo
				and v4.a_salida = v3.a_salida
				and v4.a_llegada = v4.a_llegada
				and datediff(s4.salida, now()) > 7)
	group by b.precio
	having min(b.precio))
