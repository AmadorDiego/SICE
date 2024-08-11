package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.PreguntaOpcion;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExamenDao {

    public boolean crearExamen (Examen examen) {
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
    }

    private void crearPreguntas(Connection conexion, Examen examen) throws SQLException {
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
    }

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
    }

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
    }

}


