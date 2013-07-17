drop trigger chequear_reservas_superpuestas;
create trigger chequear_reservas_superpuestas
BEFORE INSERT ON Reserva
FOR EACH ROW
begin
	IF EXISTS (select h1.id_reserva, h1.id_user
		from hace h1, tiene t1, servicio s1, usuario u1
		where NEW.id_reserva = h1.id_reserva
			and NEW.id_reserva = t1.id_reserva
			and u1.id_user = h1.id_user
			and t1.id_servicio = s1.id_servicio
			and s1.salida IN (
				(select s2.salida
					from servicio s2, hace h2, tiene t2, reserva r2
					where r2.id_reserva <> NEW.id_reserva
						and h2.id_reserva = r2.id_reserva
						and h2.id_user = h1.id_user
						and r2.id_reserva = t2.id_reserva
						and t2.id_servicio = s2.id_servicio)
/*Hasta aca tengo todas las reservas de un usuario son en distinta fecha*/
/*				EXCEPT
				(select s3.salida
				from reserva r3, hace h3, tiene t3, servicio s3, usuario u3, vuelo v3
				where r3.id_reserva = h3.id_reserva
					and r3.id_reserva = t3.id_reserva
					and u3.id_user = h3.id_user
					and t3.id_servicio = s3.id_servicio
					and s3.id_vuelo = v3.id_vuelo
					and s3.salida IN (
											select s4.fecha_salida
											from servicio s4, hace h4, tiene t4, reserva r4, vuelo v4
											where r4.id_reserva <> r3.id_reserva
												and h4.id_reserva = r4.id_reserva
												and h4.id_user = h3.id_user
												and r4.id_reserva = t4.id_reserva
												and t4.id_servicio = s4.id_servicio
												and s4.id_vuelo = v4.id_vuelo
												and v4.a_salida = v3.a_salida
												and v4.a_llegada = v4.a_llegada
												and data_sub(s4.fecha_salida, now()) > 7)*/
				-- group by r3.id_reserva
			-- 	having count (*) < 3
			--	)
			)
	) THEN
					SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT = 'No se puede insertar la reserva';
				END IF;
/*Excepto que ademas de ser reservas en la misma fecha de salida, sea entre los mismos aeropuertos de origen y destino*/
/*y la fecha de partida no es dentro de los proximos 7 dias*/
/*y solo haya a lo sumo 2 reservas de este tipo*/
end;
//
