	select * from division_academica;
    select * from carrera;
    select * from usuario;
	select id_usuario, nombre_usuario, apellido_usuario, correo_electronico, fecha_registrado, id_tipo_usuario, nombre_carrera
    from usuario left join carrera on carrera_id_carrera = id_carrera;
    select * from periodo;
	select * from grupo;
	select * from grupo_tiene_usuario;
    select * from examen;
	select * from aplicacion;
	select * from pregunta;
    select * from examen_tiene_pregunta;
	select * from opcion;
    select * from pregunta_opcion;
	select * from aplicacion;
    select * from respuesta_opcion;
    select * from respuesta_abierta;


/*
	en la columna llamada "estado" de la tabla "usuario" el...
	0 = deshabilitado
	1 = habilitado
	2 = eliminado (de manera lógica)

	id_tipo_usuario

	1		Administrador
	2		Docente
	3		Alumno
	4		Admin/Docente


    id_tipo_pregunta

	1		abierta
	2		cerrada
*/

