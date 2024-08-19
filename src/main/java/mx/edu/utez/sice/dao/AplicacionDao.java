package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Aplicacion;
import mx.edu.utez.sice.model.Usuario;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AplicacionDao {
    public boolean insertExamen(int id_examen){
        boolean flag = false;
        String query = "insert into aplicacion (preiodo_id_periodo, examen_id_examen) values (1, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_examen);
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean insertPreguntaAbierta(int id_pregunta, int id_aplicacion, String respuesta){
        boolean flag = false;
        String query = "insert into respuesta_abierta (pregunta_id_pregunta, aplicacion_id_aplicacion, respuesta, correcta) values (?, ?, ?, 0);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_pregunta);
            ps.setInt(2,id_aplicacion);
            ps.setString(3,respuesta);
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean insertPreguntaCerrada(int id_pregunta, int id_opcion, int id_aplicacion){
        boolean flag = false;
        String query = "insert into respuesta_opcion values (?,?,?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_pregunta);
            ps.setInt(2,id_opcion);
            ps.setInt(3,id_aplicacion);
            if(ps.executeUpdate()>0){
                flag = true;
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public int getOne(int id_examen) {
        int id_aplicacion = 0;
        String query = "select id_aplicacion from aplicacion where examen_id_examen = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_examen);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                id_aplicacion = (rs.getInt("id_aplicacion"));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id_aplicacion;
    }
}
