package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.model.Usuario;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ExamenDao {
    public boolean insertExamen(Examen examen) {
        String query = "INSERT INTO examen (nombre_examen, cantidad_preguntas, estado, descripcion, usuario_id_usuario) VALUES (?, ?, ?, ?, ?);";
        try (Connection conn = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, examen.getNombre_examen());
            ps.setInt(2, examen.getCantidad_preguntas());
            ps.setBoolean(3, examen.isEstado());
            ps.setString(4, examen.getDescripcion());
            ps.setInt(5, examen.getId_usuario());

            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public ArrayList<Examen> getAll() {
        ArrayList<Examen> examenes = new ArrayList<>();
        String query = "SELECT * FROM examen";
        try (Connection conn = DatabaseConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Examen examen = new Examen();
                examen.setId_examen(rs.getInt("id_examen"));
                examen.setNombre_examen(rs.getString("nombre_examen"));
                examen.setCantidad_preguntas(rs.getInt("cantidad_preguntas"));
                examen.setEstado(rs.getBoolean("estado"));
                examen.setDescripcion(rs.getString("descripcion"));
                examen.setId_usuario(rs.getInt("usuario_id_usuario"));
                examenes.add(examen);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return examenes;
    }

    // Otros métodos CRUD según sea necesario
}



