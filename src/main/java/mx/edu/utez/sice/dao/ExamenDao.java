package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.PreguntaOpcion;
import mx.edu.utez.sice.model.Usuario;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExamenDao {

    /*public boolean crearExamen (Examen examen) {
            try (Connection conexion = DatabaseConnectionManager.getConnection()) {
                conexion.setAutoCommit(false);
                try {
                    String sql = "CALL CrearExamen(?, ?, ?, ?, ?, ?)";
                    try (CallableStatement stmt = conexion.prepareCall(sql)) {
                        stmt.setString(1, examen.getNombre_examen());
                        stmt.setInt(2, examen.getCantidad_preguntas());
                        stmt.setInt(3, examen.getEstado());
                        stmt.setString(4, examen.getDescripcion());
                        stmt.setInt(5, examen.getId_usuario());
                        stmt.registerOutParameter(6, Types.INTEGER);

                        stmt.execute();

                        int idExamen = stmt.getInt(6);
                        examen.setId_examen(idExamen);
                    }

                    crearPreguntas(conexion, examen);

                    conexion.commit();
                    return true;
                } catch (SQLException e) {
                    conexion.rollback();
                    e.printStackTrace();
                    return false;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }
        }*/
    public boolean insertExamen(Examen examen){
        boolean flag = false;
        String query = "insert into examen (nombre_examen, cantidad_preguntas, descripcion) values (?, ?, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,examen.getNombre_examen());
            ps.setInt(2,examen.getCantidad_preguntas());
            ps.setString(3,examen.getDescripcion());
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean insertExamenUsuario(int id_usuario, int id_examen){
        boolean flag = false;
        String query = "insert into usuario_tiene_examen (usuario_id_usuario, examen_id_examen) values (?, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_usuario);
            ps.setInt(2,id_examen);
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean insertExamenPreguntas(int id_examen, int id_pregunta){
        boolean flag = false;
        String query = "insert into examen_tiene_pregunta (examen_id_examen, pregunta_id_pregunta) values (?, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_examen);
            ps.setInt(2,id_pregunta);
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public int getOne(Examen examen){
        int id_examen = 0;
        String query = "SELECT id_examen FROM examen where nombre_examen = ? and cantidad_preguntas = ? and estado = 0 and descripcion = ? order by id_examen desc limit 1;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,examen.getNombre_examen());
            ps.setInt(2,examen.getCantidad_preguntas());
            ps.setString(3,examen.getDescripcion());
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                id_examen = (rs.getInt("id_examen"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id_examen;
    }

    //obtiene la información de un examen por su ID
    public Examen getOne(int id_examen){
        Examen examen = new Examen();
        String query = "SELECT * FROM examen where id_examen = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_examen);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                examen.setId_examen(rs.getInt("id_examen"));
                examen.setNombre_examen(rs.getString("nombre_examen"));
                examen.setCantidad_preguntas(rs.getInt("cantidad_preguntas"));
                examen.setEstado(rs.getInt("estado"));
                examen.setDescripcion(rs.getString("descripcion"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return examen;
    }

    public ArrayList<Examen> getAll(int id_usuario) {
        ArrayList<Examen> lista = new ArrayList<>();
        String query = "SELECT id_examen, nombre_examen, cantidad_preguntas, e.estado, descripcion FROM examen e join usuario_tiene_examen on id_examen = examen_id_examen join usuario on usuario_id_usuario = id_usuario where id_usuario = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id_usuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Examen examen = new Examen();
                examen.setId_examen(rs.getInt("id_examen"));
                examen.setNombre_examen(rs.getString("nombre_examen"));
                examen.setCantidad_preguntas(rs.getInt("cantidad_preguntas"));
                examen.setEstado(rs.getInt("estado"));
                examen.setDescripcion(rs.getString("descripcion"));
                lista.add(examen);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // agregacion de Piero
    public List<Examen> filtrarExamenes(int idGrado, int idGrupo, int idDivision, int idCarrera, int idExamen) {
        List<Examen> lista = new ArrayList<>();
        String sql = "SELECT e.nombre_examen, e.descripcion, e.cantidad_preguntas, e.estado, u.nombre_usuario, u.apellido_usuario "
                + "FROM examen e "
                + "JOIN usuario_tiene_examen ute ON e.id_examen = ute.examen_id_examen "
                + "JOIN usuario u ON ute.usuario_id_usuario = u.id_usuario "
                + "WHERE e.estado = 2 AND u.id_tipo_usuario = 3";

        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Examen examen = new Examen();
                examen.setNombre_examen(rs.getString("nombre_examen"));
                examen.setDescripcion(rs.getString("descripcion"));
                examen.setCantidad_preguntas(rs.getInt("cantidad_preguntas"));
                examen.setEstado(rs.getInt("estado"));
                // Agregar los datos del usuario si es necesario
                lista.add(examen);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }




    /*private void crearPreguntas(Connection conexion, Examen examen) throws SQLException {
        String sql = "CALL CrearPregunta(?, ?, ?, ?)";
        try (CallableStatement stmt = conexion.prepareCall(sql)) {
            for (Pregunta pregunta : examen.getPreguntas()) {
                stmt.setInt(1, examen.getId_examen());
                stmt.setString(2, pregunta.getPregunta());
                stmt.setInt(3, pregunta.getId_tipo_pregunta());
                stmt.registerOutParameter(4, Types.INTEGER);

                stmt.execute();

                int idPregunta = stmt.getInt(4);
                pregunta.setId_pregunta(idPregunta);

                if (pregunta.getId_tipo_pregunta() == 2) { // Pregunta cerrada (opción múltiple)
                    crearOpciones(conexion, pregunta);
                }
            }
        }
    }

    private void crearOpciones(Connection conexion, Pregunta pregunta) throws SQLException {
        String sql = "CALL CrearOpcion(?, ?, ?, ?)";
        try (CallableStatement stmt = conexion.prepareCall(sql)) {
            for (PreguntaOpcion preguntaOpcion : pregunta.getOpciones()) {
                stmt.setInt(1, pregunta.getId_pregunta());
                stmt.setInt(2, preguntaOpcion.getId_opcion());
                stmt.setBoolean(3, preguntaOpcion.isCorrecta());
                stmt.registerOutParameter(4, Types.INTEGER);

                stmt.execute();

                int idOpcion = stmt.getInt(4);
                preguntaOpcion.setId_opcion(idOpcion);
                preguntaOpcion.getOpcion().setId_opcion(idOpcion);
            }
        }
    }
/*
    //Codigo que teniamos desde pun principio
    public boolean insertExamen(Examen examen) {
        String query = "INSERT INTO examen (nombre_examen, cantidad_preguntas, estado, descripcion, usuario_id_usuario) VALUES (?, ?, 1, ?, ?);";
        try (Connection conn = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, examen.getNombre_examen());
            //ps.setInt(2, examen.getCantidad_preguntas());
            ps.setInt(2, examen.getEstado());
            ps.setString(3, examen.getDescripcion());
            ps.setInt(4, examen.getId_usuario());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }*//*

    public ArrayList<Examen> getAll(){
        ArrayList<Examen> lista = new ArrayList<>();
        String query = "select * from Usuario";
        try {
            Connection con = DatabaseConnectionManager.getConnection(); //conección a la base
            PreparedStatement ps = con.prepareStatement(query); //preparar la base de datos
            ResultSet rs = ps.executeQuery(); //ejecutar
            while (rs.next()) { //lo ejecuta por cada ususario en la base de datos
                Examen examen = new Examen();
                examen.setId_examen(rs.getInt("id_examen"));
                examen.setNombre_examen(rs.getString("nombre_examen"));
                examen.setCantidad_preguntas(rs.getInt("cantidad_preguntas"));
                examen.setEstado(rs.getInt("estado"));
                lista.add(examen);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return lista;
    }/*

    //se agrego getExamenes
    public List<Examen> getExamenes(String grupo, String division_academica, String carrera) {
        List<Examen> examenes = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT e.* FROM examen e JOIN usuario u ON e.usuario_id_usuario = u.id_usuario " +
                "JOIN carrera c on u.carrera_id_carrera = c.id_carrera " +
                "JOIN division_academica da ON c.division_academica_id_division_academica = da.id_division_academica WHERE 1=1");

        if (grupo != null && !grupo.isEmpty()) {
            query.append(" AND u.grupo = ?");
        }
        if (division_academica != null && !division_academica.isEmpty()) {
            query.append(" AND u.nombre_division_academica = ?");
        }
        if (carrera != null && !carrera.isEmpty()) {
            query.append(" AND u.carrera = ?");
        }

        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query.toString())) {

            int index = 1;
            if (grupo != null && !grupo.isEmpty()) {
                stmt.setString(index++, grupo);
            }
            if (division_academica != null && !division_academica.isEmpty()) {
                stmt.setString(index++, division_academica);
            }
            if (carrera != null && !carrera.isEmpty()) {
                stmt.setString(index++, carrera);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Examen examen = new Examen();

                    examen.setId_examen(rs.getInt("id_examen"));
                    examen.setNombre_examen(rs.getString("nombre_examen"));
                    examen.setCantidad_preguntas(rs.getInt("cantidad_preguntas"));
                    examen.setEstado(rs.getInt("estado"));
                    examen.setDescripcion(rs.getString("descripcion"));
                    examen.setId_usuario(rs.getInt("id_usuario"));
                    examenes.add(examen);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return examenes;
    }*/
}


