package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.*;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
//se agrego Dao grupo
public class GrupoDao {

    public Grupo getOne(int id_grupo){
        Grupo grupo = new Grupo();
        String query = "SELECT * FROM grupo where id_grupo = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_grupo);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                grupo.setId_grupo(rs.getInt("id_grupo"));
                grupo.setGrado(rs.getInt("grado"));
                grupo.setGrupo(rs.getString("grupo"));
                grupo.setId_periodo(rs.getInt("periodo_id_periodo"));
                grupo.setId_carrera(rs.getInt("carrera_id_carrera"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return grupo;
    }

    public ArrayList<Grupo> getAll() {
        ArrayList<Grupo> lista = new ArrayList<>();
        try (Connection con = DatabaseConnectionManager.getConnection()) {
            String query = "SELECT * FROM grupo";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Grupo g = new Grupo();
                g.setId_grupo(rs.getInt("id_grupo"));
                //g.setGrupo(rs.getString("grupo").charAt(0));
                g.setGrupo(rs.getString("grupo"));
                g.setGrado(rs.getInt("grado"));
                g.setId_periodo(rs.getInt("periodo_id_periodo"));
                lista.add(g);
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean imparteDocenteGrupo(int id_grupo, int id_usuario) {
        boolean flag = false;
        String query = "select * from usuario_tiene_grupo where grupo_id_grupo = ? and usuario_id_usuario = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_grupo);
            ps.setInt(2,id_usuario);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                flag = true;
            }
            rs.close();
            ps.close();
            con.close();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    public ArrayList<Grupo> getAll(int id_carrera) {
        ArrayList<Grupo> lista = new ArrayList<>();
        String query = "select id_grupo, grado, grupo, periodo_id_periodo, carrera_id_carrera from grupo where carrera_id_carrera = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id_carrera);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Grupo grupo = new Grupo();
                grupo.setId_grupo(rs.getInt("id_grupo"));
                grupo.setGrado(rs.getInt("grado"));
                grupo.setGrupo(rs.getString("grupo"));
                grupo.setId_periodo(rs.getInt("periodo_id_periodo"));
                grupo.setId_carrera(rs.getInt("carrera_id_carrera"));
                lista.add(grupo);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean insertUsuarioGrupo(int id_grupo, int id_usuario){
        boolean flag = false;
        String query = "insert into usuario_tiene_grupo values (?, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_grupo);
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

    public boolean crearGrupo(int id_carrera, int grado, String grupo, int id_periodo) {
        boolean flag = false;
        String query = "insert into grupo (carrera_id_carrera, grado, grupo, periodo_id_periodo) values (?, ?, ?, ?);";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_carrera);
            ps.setInt(2,grado);
            ps.setString(3,grupo);
            ps.setInt(4,id_periodo);
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

    public boolean deleteUsuariosGrupo(int id_grupo, int id_usuario) {
        boolean flag = false;
        String query = "delete from usuario_tiene_grupo where grupo_id_grupo = ? and usuario_id_usuario = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_grupo);
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

    public boolean deleteGrupo(int id_grupo) {
        boolean flag = false;
        String query = "delete from grupo where id_grupo = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_grupo);
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

    public boolean updateGrupo(int id_carrera, int grado, String grupo, int id_periodo, int id_grupo) {
        boolean flag = false;
        String query = "update grupo set carrera_id_carrera = ?, grado = ?, grupo = ?, periodo_id_periodo = ? where id_grupo = ?;";
        try{
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,id_carrera);
            ps.setInt(2,grado);
            ps.setString(3,grupo);
            ps.setInt(4,id_periodo);
            ps.setInt(5,id_grupo);
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