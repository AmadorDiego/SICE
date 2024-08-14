package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Carrera;
import mx.edu.utez.sice.model.DivisionAcademica;
import mx.edu.utez.sice.model.Grupo;
import mx.edu.utez.sice.model.Usuario;
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
                g.setGrupo(rs.getString("grupo").charAt(0));
                g.setGrado(rs.getInt("grado"));
                g.setId_periodo(rs.getInt("periodo_id_periodo"));
                lista.add(g);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
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
                grupo.setGrupo(rs.getString("grupo").charAt(0));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return grupo;
    }

    public ArrayList<Grupo> getInfo() {
        ArrayList<Grupo> grupos = new ArrayList<>();
        try {
            con = DatabaseConnectionManager.getConnection();
            String query = "SELECT g.id_grupo, g.grado, g.grupo, d.nombre_division_academica, c.nombre_carrera " +
                    "FROM grupo g " +
                    "JOIN grupo_tiene_usuario gu ON g.id_grupo = gu.grupo_id_grupo " +
                    "JOIN usuario u ON u.id_usuario = gu.usuario_id_usuario " +
                    "JOIN carrera c ON u.carrera_id_carrera = c.id_carrera " +
                    "JOIN division_academica d ON c.division_academica_id_division_academica = d.id_division_academica";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Grupo grupo = new Grupo();
                grupo.setId_grupo(rs.getInt("id_grupo"));
                grupo.setGrado(rs.getInt("grado"));
                grupo.setGrupo(rs.getString("grupo").charAt(0));


                Carrera carrera = new Carrera();
                carrera.setCarrera(rs.getString("nombre_carrera"));

                DivisionAcademica division = new DivisionAcademica();
                division.setDivision_academica(rs.getString("nombre_division_academica"));

                grupos.add(grupo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return grupos;
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

