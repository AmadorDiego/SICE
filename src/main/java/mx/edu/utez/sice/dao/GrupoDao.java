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

    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean insertAlumnoGrupo(int id_grupo, int id_usuario){
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
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public boolean insertGrupoDocente(int id_grupo, int id_usuario) {
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
        }catch(SQLException e){
            e.printStackTrace();
        }
        return flag;
    }

    public Grupo getById(int id) {
        Grupo grupo = new Grupo();
        try {
            con = DatabaseConnectionManager.getConnection();
            String query = "SELECT * FROM grupo WHERE id_grupo=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                grupo = new Grupo();
                grupo.setId_grupo(rs.getInt("id_grupo"));
                grupo.setGrado(rs.getInt("grado"));
                //grupo.setGrupo(rs.getString("grupo").charAt(0));
                grupo.setGrupo(rs.getString("grupo"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return grupo;
    }

    public ArrayList<Tabla> getInfo() {
        ArrayList<Tabla> tabla = new ArrayList<>();
        try {
            con = DatabaseConnectionManager.getConnection();
            String query = "SELECT g.id_grupo, g.grado, g.grupo, d.nombre_division_academica, c.nombre_carrera " +
                    "FROM grupo g " +
                    "JOIN grupo_tiene_usuario gu ON g.id_grupo = gu.grupo_id_grupo " +
                    "JOIN usuario u ON u.id_usuario = gu.usuario_id_usuario " +
                    "JOIN carrera c ON u.carrera_id_carrera = c.id_carrera " +
                    "JOIN division_academica d ON c.division_academica_id_division_academica = d.id_division_academica " +
                    "GROUP BY g.id_grupo, g.grado, g.grupo, d.nombre_division_academica, c.nombre_carrera;";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Tabla t = new Tabla();

                Grupo grupo = new Grupo();
                grupo.setId_grupo(rs.getInt("id_grupo"));
                grupo.setGrado(rs.getInt("grado"));
                //grupo.setGrupo(rs.getString("grupo").charAt(0));
                grupo.setGrupo(rs.getString("grupo"));
                t.setGrupo(grupo);


                Carrera carrera = new Carrera();
                carrera.setCarrera(rs.getString("nombre_carrera"));
                t.setCarrera(carrera);


                DivisionAcademica division = new DivisionAcademica();
                division.setDivision_academica(rs.getString("nombre_division_academica"));
                //t.setDivision(division);
                t.setDivisionAcademica(division);

                tabla.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return tabla;
    }

    public ArrayList<Tabla> getInfo(int id_grupo, int id_division, int id_carrera) {
        ArrayList<Tabla> tabla = new ArrayList<>();
        try {
            con = DatabaseConnectionManager.getConnection();
            String query = "SELECT g.id_grupo, g.grupo, g.grado, d.nombre_division_academica, c.nombre_carrera " +
                    "FROM grupo g " +
                    "JOIN grupo_tiene_carrera gc ON g.id_grupo = gc.grupo_id_grupo " +
                    "JOIN carrera c ON gc.carrera_id_carrera = c.id_carrera " +
                    "JOIN division_academica d ON c.division_academica_id_division_academica = d.id_division_academica " +
                    "WHERE g.id_grupo = ? AND d.id_division_academica = ? AND c.id_carrera = ? " +
                    "GROUP BY g.id_grupo, g.grupo, g.grado, d.nombre_division_academica, c.nombre_carrera;";
            ps = con.prepareStatement(query);
            ps.setInt(1,id_grupo);
            ps.setInt(2,id_division);
            ps.setInt(3,id_carrera);
            rs = ps.executeQuery();

            while (rs.next()) {
                Tabla t = new Tabla();

                Grupo grupo = new Grupo();
                grupo.setId_grupo(rs.getInt("id_grupo"));
                grupo.setGrado(rs.getInt("grado"));
                //grupo.setGrupo(rs.getString("grupo").charAt(0));
                grupo.setGrupo(rs.getString("grupo"));
                t.setGrupo(grupo);


                Carrera carrera = new Carrera();
                carrera.setCarrera(rs.getString("nombre_carrera"));
                t.setCarrera(carrera);


                DivisionAcademica division = new DivisionAcademica();
                division.setDivision_academica(rs.getString("nombre_division_academica"));
                //t.setDivision(division);
                t.setDivisionAcademica(division);

                tabla.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return tabla;
    }

    private void closeConnections() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}