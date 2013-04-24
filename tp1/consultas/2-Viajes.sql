create function viajes (@fecha_1 date, @fecha_2 date) as
begin
	select * from aeropuerto a
	inner join vuelo v 	
	on v.sale_de = a.id_a
	inner join servicio s 	
	on s.nro_vuelo = v.nro_vuelo
	inner join reserva r
	on r.id_servicio = s.id_servicio
	inner join usuario u
	on u.id_usuario = r.id_usuario
	as usuarios_que_salieron_de_aeropuerto 
		
	select count( usuario ) as cant, 
		date_format(fecha, '%m %y'), aeropuerto 
	from usuarios_que_salieron_de_aeropuerto 
	where fecha between @fecha_1 and @fecha_2
	group by fecha as personas_que_salieron

	select * from aeropuerto a
	inner join vuelo v 
	on v.llega_a = a.id_a
	inner join servicio s 
	on s.nro_vuelo = v.nro_vuelo
	inner join reserva r 
	on r.id_servicio = s.id_servicio 
	and r.estado = realizado
	inner join usuario u
	on u.id_usuario = r.id_usuario
	as usuarios_que_llegaron_a_aeropuerto		 
		
	select count( usuario ) as cant, 
		date_format(fecha, '%m %y'), aeropuerto 
	from usuarios_que_llegaron_a_aeropuerto 
	where fecha between @fecha_1 and @fecha_2 
	group by fecha as personas_que_llegaron

	select (s.cant + l.cant) as cant_total, 
		s.cant, l.cant, fecha, aerop
	from personas_que_salieron as s, 
		personas_que_llegaron as l 
	order by cant_total
end
 
