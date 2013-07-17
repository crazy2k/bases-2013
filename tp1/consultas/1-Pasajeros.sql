select dp.nombre, dp.apellido, u.id_user
from Usuario u, DatosPersonales dp
where not exists 
(
    select p.id_pais, p.nombre
		from Vuelo v1, Aeropuerto a1, Ciudad c1, Pais p
		where (v1.a_salida = a1.id_a or v1.a_llegada = a1.id_a)
		and a1.id_ciudad = c1.id_ciudad
		and c1.id_pais = p.id_pais
		and not exists
    (
        select *
        from Hace h, Reserva r, Tiene t, Servicio s, Vuelo v, Aeropuerto a, Ciudad c
        where u.id_user = h.id_user 
        and h.id_reserva = r.id_reserva 
        and r.id_reserva = t.id_res 
        and t.id_serv = s.id_servicio
        and s.id_vuelo = v.id_vuelo 
        and (v.a_llegada = a.id_a or v.a_salida = a.id_a) 
        and a.id_ciudad = c.id_ciudad 
        and c.id_pais = p.id_pais
        and ((s.salida >= date_sub(now(), interval 5 year)) 
            or (s.llegada >= date_sub(now(), interval 5 year)))  
    )
)
and u.id_user = dp.id_user
