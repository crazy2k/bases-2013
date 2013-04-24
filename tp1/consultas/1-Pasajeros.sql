SELECT dp.nombre, dp.apellido, id_user
FROM Usuario u, DatosPersonales dp
WHERE NOT EXISTS 
(
    SELECT *
    FROM Pais p
    WHERE NOT EXISTS 
    (
        SELECT *
        FROM Hace h, Reserva r, Tiene t, Servicio s, Vuelo v,
            Aeropuerto a, Ciudad c
        WHERE u.id_user = h.id_user 
        AND h.nro_reserva = r.nro_reserva 
        AND r.nro_reserva = t.nro_reserva 
        AND t.id_servicio = s.id_servicio
        AND s.nro_vuelo = v.nro_vuelo 
        AND (v.llega_a = a.id_a OR v.sale_de = a.id_a) 
        AND a.id_ciudad = c.id_ciudad 
        AND c.id_pais = p.id_pais 
        AND ((s.fecha_hora_salida >= DATE_SUB(NOW(), INTERVAL 5 YEAR)) 
            OR (s.fecha_hora_salida >= DATE_SUB(NOW(), INTERVAL 5 YEAR)))  
    )
)
AND u.id_user = dp.id_user
