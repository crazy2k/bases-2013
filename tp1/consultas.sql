-- Consulta 1 (Terminada; sólo revisar el TODO)

SELECT dp.nombre, dp.apellido, id_user
FROM Usuario u, DatosPersonales dp
WHERE NOT EXISTS (
    SELECT *
    FROM Pais p
    WHERE NOT EXISTS (
        SELECT *
        FROM Hace h, Reserva r, Tiene t, Servicio s, Vuelo v,
            Aeropuerto a, Ciudad c
        WHERE u.id_user = h.id_user AND h.nro_reserva = r.nro_reserva AND
            r.nro_reserva = t.nro_reserva AND
            t.id_servicio = s.id_servicio AND s.nro_vuelo = v.nro_vuelo AND
            (v.llega_a = a.id_a OR v.sale_de = a.id_a) AND
            a.id_ciudad = c.id_ciudad AND c.id_pais = p.id_pais AND
            -- TODO: Ver si hay una forma genérica de hacer esto
            ((s.fecha_hora_salida >= DATE_SUB(NOW(), INTERVAL 5 YEAR)) OR
              (s.fecha_hora_salida >= DATE_SUB(NOW(), INTERVAL 5 YEAR)))  
        )
    )
    AND u.id_user = dp.id_user


-- Consulta 2

create trigger chequear_reservas_superpuestas
before insertion on Reserva
for each row
begin
	fecha_salida := select s.fecha_salida
	from servicio s, tiene t	
	where s.id_servicio = t.id_servicio 
	and t.nro_reserva = :new.nro_reserva

	fecha_llegada := select s.fecha_salida
	from servicio s, tiene t
	where s.id_servicio = t.id_servicio 
	and t.nro_reserva = :new.nro_reserva

	aeropuerto_llegada := select a.id_a
    from servicio s, tiene t, vuelvo v, aeropuerto a
    where s.id_servicio = t.id_servicio 
    and s.nro_vuelo = v.nro_vuelo 
    and v.llega_a = a.id_a

	user := select u.id_user 
	from usuario u, hace h
	where h.id_user = u.id_user 
	and h.nro_reserva = .new.nro_reserva

	if data_sub(fecha_salida, now()) < 7 
	and exists(
	  select *
	  from reserva r, tiene t, servicio s, hace h, usuario u
	  where t.nro_reserva = r.nro_reserva
	  and t.id_servicio = s.id_servicio
	  and h.nro_reserva = r.nro_reserva
	  and h.id_user = u.id_user
	  /* Hasta aca tenemos las reservas del usuario */
	  and (not
	  	(s.fecha_salida >= fecha_llegada 
	  		or s.fecha_llegada <= fecha_salida))
	)
	begin
	  raiserror ('Se superpone la reserva con una ya realizada.', 16, 1);
	  rollback transaction;
	  return
	end;
end


-- Consulta 3 (NO terminada)

CREATE PROCEDURE reservas_superpuestas()
LANGUAGE SQL
BEGIN

END
