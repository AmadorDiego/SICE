package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.*;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OpcionDao {

    public int insertOpcion(Opcion opcion){
        int id_opcion = 0;
        String query = "INSERT INTO opcion (opcion) VALUES (?)";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1,opcion.getOpcion());
            if(ps.executeUpdate()>0){
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()){
                    id_opcion = rs.getInt(1);
                }
            }
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return id_opcion;
    }

    //OpcionDao ------
    public ArrayList<Opcion> getAll(int id_pregunta) {
        ArrayList<Opcion> listaOpciones = new ArrayList<>();
        String query = "select id_opcion, opcion, correcta from opcion join pregunta_opcion on id_opcion = opcion_id_opcion\n" +
                "    join pregunta on pregunta_id_pregunta = id_pregunta where id_pregunta = ? and id_tipo_pregunta = 2;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id_pregunta);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Opcion opcion = new Opcion();
                opcion.setId_opcion(rs.getInt("id_opcion"));
                opcion.setOpcion(rs.getString("opcion"));
                listaOpciones.add(opcion);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaOpciones;
    }

    public PreguntaOpcion getOpcionCorrecta(int id_opcion) {
        PreguntaOpcion preguntaOpcion = new PreguntaOpcion();
        String query = "select * from pregunta_opcion where opcion_id_opcion = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_opcion);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                preguntaOpcion.setId_pregunta(rs.getInt("pregunta_id_pregunta"));
                preguntaOpcion.setId_opcion(rs.getInt("opcion_id_opcion"));
                preguntaOpcion.setCorrecta(rs.getInt("correcta"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return preguntaOpcion;
    }


    // Método para actualizar una opción
    public boolean updateOpcion(int idOpcion, String textoOpcion) {
        String query = "UPDATE opcion SET opcion = ? WHERE id_opcion = ?";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, textoOpcion);
            ps.setInt(2, idOpcion);

            return ps.executeUpdate() > 0; // Retorna true si se actualizó correctamente

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    // Método para actualizar el estado de la opción correcta
    public boolean updateOpcionCorrecta(int idOpcion, int correcta) {
        String query = "UPDATE pregunta_opcion SET correcta = ? WHERE opcion_id_opcion = ?";
        try (Connection con = DatabaseConnectionManager.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, correcta);
            ps.setInt(2, idOpcion);

            return ps.executeUpdate() > 0; // Retorna true si se actualizó correctamente

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public PreguntaOpcion getRespuestaOpcion(int idPregunta, int idAplicacion) {
        PreguntaOpcion preguntaOpcion = new PreguntaOpcion();
        String query = "select pregunta_opcion_opcion_id_opcion from respuesta_opcion where pregunta_opcion_pregunta_id_pregunta = ? and aplicacion_id_aplicacion = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,idPregunta);
            ps.setInt(2,idAplicacion);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                preguntaOpcion.setId_opcion(rs.getInt("pregunta_opcion_opcion_id_opcion"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return preguntaOpcion;
    }
}