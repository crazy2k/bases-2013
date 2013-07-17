drop trigger chequear_fechas_correctas;
delimiter //
create trigger chequear_fechas_correctas
BEFORE UPDATE ON Reserva
FOR EACH ROW
begin
    IF NEW.id_estado = 3 THEN
        IF EXISTS (
            SELECT 1
            FROM Servicio s, Tiene t
            WHERE
                s.id_servicio = t.id_serv AND
                t.id_res = r.id_reserva AND
                (datediff(now(), s.salida) < 0) AND
                (datediff(now(), s.llegada) < 0)
        ) THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT =
                    'No se puede cambiar el  estado de la reserva';
        END IF;
    END IF;
end;
//
delimiter ;

/*
drop trigger chequear_reserva_valida;
delimiter //
create trigger chequear_reserva_valida
BEFORE INSERT ON Reserva
FOR EACH ROW
begin
    IF NEW.id_estado = 3 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
                'No se puede agregar una reserva realizada';
    END IF;
end;
//
delimiter ;
*/
