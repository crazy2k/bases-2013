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


-- Consulta 2 (NO terminada)

CREATE TRIGGER chequear_reservas_superpuestas
BEFORE INSERT ON Tiene
FOR EACH ROW
BEGIN
    fecha_salida := SELECT s.fecha_salida
        FROM Servicio s
        WHERE s.id_servicio = :NEW.id_servicio

    aeropuerto_salida := SELECT a.id_a
        FROM Servicio s, Vuelvo v, Aeropuerto a
        WHERE :NEW.id_servicio = s.id_servicio = AND
            s.nro_vuelo = v.nro_vuelo AND v.sale_de = a.id_a

    aeropuerto_llegada := SELECT a.id_a
        FROM Servicio s, Vuelvo v, Aeropuerto a
        WHERE :NEW.id_servicio = s.id_servicio = AND
            s.nro_vuelo = v.nro_vuelo AND v.llega_a = a.id_a

    id_user := SELECT u.id_user
        FROM Usuario u, Hace h, Reserva r,
        WHERE u.id_user = h.id_user AND h.nro_reserva = r.nro_reserva AND
        r.nro_reserva = :NEW.nro_reserva

    IF DATE_SUB(fecha_salida, NOW()) < 7 AND
        EXISTS(
            SELECT 1
            FROM Hace h, Reserva r, Tiene t, Servicio s, Vuelo v
            WHERE id_user = h.id_user AND h.nro_reserva = r.nro_reserva AND
                r.nro_reserva = t.nro_reserva AND t.id_servicio = s.id_servicio AND
                s.fecha_salida = fecha_salida AND s.nro_vuelo = v.nro_vuelo AND
                v.llega_a = aeropuerto_salida AND v.sale_de = aeropuerto_llegada)
        THEN
            -- No permitir inserción de Tiene y borrar Reserva adecuadamente
    END IF;
END


-- Consulta 3 (NO terminada)

CREATE PROCEDURE reservas_superpuestas()
LANGUAGE SQL
BEGIN

END
