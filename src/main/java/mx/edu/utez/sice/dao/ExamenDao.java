package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Usuario;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;

public class ExamenDao {
    public boolean insertExamen(Examen examen) {
        String query = "INSERT INTO examen (nombre_examen, cantidad_preguntas, estado, descripcion, usuario_id_usuario) VALUES (?, 1, ?, ?, ?);";
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

    // Otros métodos CRUD según sea necesario
/*
    public boolean insertExamen(Examen examen) {
        String query = "INSERT INTO examen (nombre_examen, cantidad_preguntas, estado, descripcion, usuario_id_usuario) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, examen.getNombre_examen());
            pstmt.setInt(2, examen.getCantidad_preguntas());
            pstmt.setBoolean(3, examen.getEstado());
            pstmt.setString(4, examen.getDescripcion());
            pstmt.setInt(5, examen.getId_usuario());

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Examen> getAllExamenes() {
        List<Examen> examenes = new ArrayList<>();
        String query = "SELECT * FROM examen";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Examen examen = new Examen(
                        //Aqui esta el error de los getters
                        rs.getInt("id_examen"),
                        rs.getString("nombre_examen"),
                        rs.getInt("cantidad_preguntas"),
                        rs.getBoolean("estado"),
                        rs.getString("descripcion"),
                        rs.getInt("usuario_id_usuario")
                );
                examenes.add(examen);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return examenes;
    }*/

    // Otros métodos CRUD según sea necesario
}



