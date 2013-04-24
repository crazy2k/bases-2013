select dp.nombre, dp.apellido, id_user
from usuario u, datospersonales dp
where not exists 
(
    select *
    from pais p
    where not exists 
    (
        select *
        from hace h, reserva r, tiene t, servicio s, vuelo v,
            aeropuerto a, ciudad c
        where u.id_user = h.id_user 
        and h.nro_reserva = r.nro_reserva 
        and r.nro_reserva = t.nro_reserva 
        and t.id_servicio = s.id_servicio
        and s.nro_vuelo = v.nro_vuelo 
        and (v.llega_a = a.id_a or v.sale_de = a.id_a) 
        and a.id_ciudad = c.id_ciudad 
        and c.id_pais = p.id_pais 
        and ((s.fecha >= date_sub(now(), interval 5 year)) 
            or (s.fecha >= date_sub(now(), interval 5 year)))  
    )
)
and u.id_user = dp.id_user

