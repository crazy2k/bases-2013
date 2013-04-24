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
	  from reserva r, tiene t, servicio s, 
	  		hace h, usuario u, estado e
	  where t.nro_reserva = r.nro_reserva
	  and t.id_servicio = s.id_servicio
	  and h.nro_reserva = r.nro_reserva
	  and h.id_user = u.id_user
	  and r.codigo_estado = e.codigo_estado
	  and e.codigo_estado = 2 /* Confirmada */
	  /* Hasta aca tenemos las reservas del usuario */
	  and (not
	  	(s.fecha_salida >= fecha_llegada 
	  		or s.fecha_llegada <= fecha_salida))
	)
	begin
	  raiserror ('Se superpone la reserva con 
	  				una ya realizada.', 5, 1);
	  rollback transaction;
	  return
	end;
end;