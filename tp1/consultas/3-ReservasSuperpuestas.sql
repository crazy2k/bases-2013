drop trigger chequear_reservas_superpuestas;
delimiter //
create trigger chequear_reservas_superpuestas
BEFORE INSERT ON Tiene
FOR EACH ROW
begin
	IF EXISTS (select h1.id_reserva, h1.id_user
		from Hace h1, Servicio s1, Usuario u1, Reserva r1
		where h1.id_user = u1.id_user AND
			h1.id_reserva = r1.id_reserva AND
			NEW.id_res = r1.id_reserva AND
			NEW.id_serv = s1.id_servicio
            AND EXISTS(
                select s2.salida
                from Servicio s2, Tiene t2, Reserva r2, Hace h2
                where h2.id_user = u1.id_user
                    and h2.id_reserva <> h1.id_reserva
                    and h2.id_reserva = r2.id_reserva
                    and t2.id_res = r2.id_reserva
                    and t2.id_serv = s2.id_servicio
                    and s2.salida = s1.salida
                    and s1.id_servicio <> s2.id_servicio
						and s2.salida NOT IN (
							(select s3.salida
							from Reserva r3, Hace h3, Tiene t3, Servicio s3, Usuario u3, Vuelo v3
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
							) 
						)
	)) THEN
					SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT = 'No se puede insertar la reserva';
				END IF;
end;
//
delimiter ;
