package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.PreguntaOpcion;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PreguntaOpcionDao {

    //PreguntaOpcionDao
    public ArrayList<PreguntaOpcion> getAll (){
        ArrayList<PreguntaOpcion> listaOpcionesPreguntas = new ArrayList<>();
        String query = "select * from pregunta_opcion where estado = 1";

        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaOpcionesPreguntas;
    }

    public PreguntaOpcion getOne(int id_pregunta, int id_opcion) {
        PreguntaOpcion preguntaOpcion = new PreguntaOpcion();
        String query = "select * from pregunta_opcion where id_pregunta = ? and id_opcion = ?";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_pregunta);
            ps.setInt(2,id_opcion);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                preguntaOpcion.setId_pregunta(id_pregunta);
                preguntaOpcion.setId_opcion(id_opcion);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return preguntaOpcion;
    }
}
