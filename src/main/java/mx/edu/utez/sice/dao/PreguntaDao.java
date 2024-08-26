package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.PreguntaOpcion;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;

public class PreguntaDao {

    public int insertPregunta(Pregunta pregunta){
        int id_pregunta = 0;
        String query = "INSERT INTO pregunta (pregunta, id_tipo_pregunta) VALUES (?, ?)";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1,pregunta.getPregunta());
            ps.setInt(2,pregunta.getId_tipo_pregunta());
            if(ps.executeUpdate()>0){
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()){
                    id_pregunta = rs.getInt(1);
                }
            }
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return id_pregunta;
    }

    public boolean insertPreguntaOpcion(PreguntaOpcion preguntaOpcion){
        boolean flag = false;
        String query = "INSERT INTO pregunta_opcion (pregunta_id_pregunta, opcion_id_opcion, correcta) VALUES (?, ?, ?)";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,preguntaOpcion.getId_pregunta());
            ps.setInt(2,preguntaOpcion.getId_opcion());
            ps.setInt(3,preguntaOpcion.getCorrecta());
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

    //PreguntaDao -----
    public ArrayList<Pregunta> getAll(int id_examen) {
        ArrayList<Pregunta> listaPreguntas = new ArrayList<>();
        String query = "select id_pregunta, pregunta, id_tipo_pregunta from pregunta join examen_tiene_pregunta on id_pregunta = pregunta_id_pregunta " +
                "join examen on examen_id_examen = id_examen where id_examen = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id_examen);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pregunta pregunta = new Pregunta();
                pregunta.setId_pregunta(rs.getInt("id_pregunta"));
                pregunta.setPregunta(rs.getString("pregunta"));
                pregunta.setId_tipo_pregunta(rs.getInt("id_tipo_pregunta"));
                listaPreguntas.add(pregunta);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaPreguntas;
    }

    public ArrayList<Pregunta> getAllByUsuario(int id_usuario) {
        ArrayList<Pregunta> preguntas = new ArrayList<>();
        String query = "SELECT id_pregunta, pregunta, id_tipo_pregunta FROM usuario JOIN usuario_tiene_examen ue ON id_usuario = usuario_id_usuario JOIN examen ON ue.examen_id_examen = id_examen JOIN examen_tiene_pregunta ep ON id_examen = ep.examen_id_examen JOIN pregunta ON pregunta_id_pregunta = id_pregunta where id_usuario = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id_usuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pregunta pregunta = new Pregunta();
                pregunta.setId_pregunta(rs.getInt("id_pregunta"));
                pregunta.setPregunta(rs.getString("pregunta"));
                pregunta.setId_tipo_pregunta(rs.getInt("id_tipo_pregunta"));
                preguntas.add(pregunta);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return preguntas;
    }

    //preguntaDao
    public Pregunta getOne(int id_pregunta) {
        Pregunta pregunta = null;
        String query = "SELECT id_pregunta, pregunta, id_tipo_pregunta FROM pregunta WHERE id_pregunta = ?";

        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id_pregunta);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                pregunta = new Pregunta();
                pregunta.setId_pregunta(rs.getInt("id_pregunta"));
                pregunta.setPregunta(rs.getString("pregunta"));
                pregunta.setId_tipo_pregunta(rs.getInt("id_tipo_pregunta"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pregunta;
    }

    // Método para actualizar una pregunta
    public boolean updatePregunta(int idPregunta, String textoPregunta) {
        String query = "UPDATE pregunta SET pregunta = ? WHERE id_pregunta = ?";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, textoPregunta);
            ps.setInt(2, idPregunta);

            return ps.executeUpdate() > 0; // Retorna true si se actualizó correctamente

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}