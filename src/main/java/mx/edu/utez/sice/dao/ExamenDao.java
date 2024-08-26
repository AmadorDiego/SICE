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

    public int insertExamen(Examen examen){
        int id_examen = 0;
        String query = "insert into examen (nombre_examen, cantidad_preguntas, descripcion) values (?, ?, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1,examen.getNombre_examen());
            ps.setInt(2,examen.getCantidad_preguntas());
            ps.setString(3,examen.getDescripcion());
            if(ps.executeUpdate()>0){
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()){
                    id_examen = rs.getInt(1);
                }
            }
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return id_examen;
    }

    // metodo llamado al crear un examen O metodo llamado cuando es asignado a un alumno por parte del docente
    public boolean insertExamenUsuario(int id_usuario, int id_examen){
        boolean flag = false;
        String query = "insert into usuario_tiene_examen (usuario_id_usuario, examen_id_examen, estado) values (?, ?, 1);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_usuario);
            ps.setInt(2,id_examen);
            if(ps.executeUpdate()>0){
                flag = true;
            }
            ps.close();
            con.close();
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
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
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
                examen.setDescripcion(rs.getString("descripcion"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return examen;
    }

    public ArrayList<Examen> getAll(int id_usuario) {
        ArrayList<Examen> lista = new ArrayList<>();
        String query = "SELECT id_examen, nombre_examen, cantidad_preguntas, descripcion FROM examen join usuario_tiene_examen ue on id_examen = examen_id_examen join usuario on usuario_id_usuario = id_usuario where id_usuario = ? and ue.estado != 2;";
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
                examen.setDescripcion(rs.getString("descripcion"));
                lista.add(examen);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public ArrayList<Examen> getAllAsignadosCompletados(int id_usuario) {
        ArrayList<Examen> lista = new ArrayList<>();
        String query = "SELECT id_examen, nombre_examen, cantidad_preguntas, descripcion FROM examen join usuario_tiene_examen ue on id_examen = examen_id_examen join usuario on usuario_id_usuario = id_usuario where id_usuario = ? and ue.estado != 1;";
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
                examen.setDescripcion(rs.getString("descripcion"));
                lista.add(examen);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // metodo llamado al asignar un examen por docente O metodo llamado cuando un alumno manda un examen
    public boolean examenAsignadoCompletado(int id_examen, int id_usuario) {
        boolean flag = false;
        String query = "update usuario_tiene_examen set estado = 2 where examen_id_examen = ? and usuario_id_usuario = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_examen);
            ps.setInt(2,id_usuario);
            if(ps.executeUpdate()>0){
                flag = true;
            }
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    // Método para actualizar un examen
    public boolean updateExamen(int idExamen, String nombreExamen, String descripcion) {
        String query = "UPDATE examen SET nombre_examen = ?, descripcion = ? WHERE id_examen = ?";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, nombreExamen);
            ps.setString(2, descripcion);
            ps.setInt(3, idExamen);

            return ps.executeUpdate() > 0; // Retorna true si se actualizó correctamente

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}