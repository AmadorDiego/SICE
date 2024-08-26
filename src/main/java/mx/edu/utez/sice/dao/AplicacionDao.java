package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Aplicacion;
import mx.edu.utez.sice.model.PreguntaOpcion;
import mx.edu.utez.sice.model.RespuestaAbierta;
import mx.edu.utez.sice.model.Usuario;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.*;
import java.util.ArrayList;

public class AplicacionDao {
    public int insertExamen(int id_examen){
        int generatedId = 0;
        String query = "insert into aplicacion (periodo_id_periodo, examen_id_examen) values (1, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1,id_examen);
            if(ps.executeUpdate()>0){
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()){
                    generatedId = rs.getInt(1);
                }
            }
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return generatedId;
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
            ps.close();
            con.close();
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
            ps.close();
            con.close();
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
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id_aplicacion;
    }

    public RespuestaAbierta getRespuestaAbierta (int id_pregunta_abierta, int id_aplicacion) {
        RespuestaAbierta respuestaAbierta = new RespuestaAbierta();
        String query = "select respuesta from respuesta_abierta where pregunta_id_pregunta = ? and aplicacion_id_aplicacion = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_pregunta_abierta);
            ps.setInt(2,id_aplicacion);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                respuestaAbierta.setRespuesta(rs.getString("respuesta"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return respuestaAbierta;
    }

    public PreguntaOpcion getRespuestaOpcion (int id_pregunta_opcion, int id_aplicacion) {
        PreguntaOpcion preguntaOpcion = new PreguntaOpcion();
        String query = "select pregunta_opcion_opcion_id_opcion from respuesta_opcion where pregunta_opcion_pregunta_id_pregunta = ? and aplicacion_id_aplicacion = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_pregunta_opcion);
            ps.setInt(2,id_aplicacion);
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

    public ArrayList<Aplicacion> getAplicacionByAlumnoExamen(int id_usuario, int id_examen) {
        ArrayList<Aplicacion> aplicacion = new ArrayList<>();
        String query = "select id_aplicacion from aplicacion a join examen on a.examen_id_examen = id_examen join usuario_tiene_examen ute on id_examen = ute.examen_id_examen join usuario on usuario_id_usuario = id_usuario where a.examen_id_examen = ? and id_usuario = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_examen);
            ps.setInt(2,id_usuario);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                Aplicacion ap = new Aplicacion();
                ap.setId_aplicacion(rs.getInt("id_aplicacion"));
                aplicacion.add(ap);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return aplicacion;
    }

    public ArrayList<String> aplicacionPreguntasAbiertas (int id_aplicacion){
        ArrayList<String> respuestas_abiertas = new ArrayList<>();
        String query = "select respuesta from respuesta_abierta join aplicacion on aplicacion_id_aplicacion = id_aplicacion where id_aplicacion = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_aplicacion);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                respuestas_abiertas.add(rs.getString("respuesta"));
            }
            ps.close();
            con.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
        return respuestas_abiertas;
    }

    public boolean aplicacionPreguntasCerradas (int id_aplicacion){
        boolean flag = false;
        String query = "select pregunta_opcion_opcion_id_opcion from respuesta_opcion join aplicacion on aplicacion_id_aplicacion = id_aplicacion where id_aplicacion = 14;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_pregunta);
            ps.setInt(2,id_aplicacion);
            ps.setString(3,respuesta);
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
}
