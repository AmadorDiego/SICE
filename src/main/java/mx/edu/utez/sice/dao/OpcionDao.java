package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Opcion;
import mx.edu.utez.sice.model.Pregunta;
import mx.edu.utez.sice.model.PreguntaOpcion;
import mx.edu.utez.sice.model.Usuario;
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

    //OpcionDao
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
}