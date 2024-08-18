package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.Carrera;
import mx.edu.utez.sice.model.DivisionAcademica;
import mx.edu.utez.sice.model.Examen;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CarreraDao {
//se agrego Dao carrera
    public ArrayList<Carrera> getAll() {
        ArrayList<Carrera> lista = new ArrayList<>();
        String query = "SELECT * FROM carrera";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Carrera carrera = new Carrera();
                carrera.setId_carrera(rs.getInt("id_carrera"));
                carrera.setCarrera(rs.getString("nombre_carrera"));
                carrera.setId_division_academica(rs.getInt("division_academica_id_division_academica"));
                lista.add(carrera);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public ArrayList<Carrera> getAll(int id_division_academica) {
        ArrayList<Carrera> carreras = new ArrayList<>();
        String query = "select id_carrera, nombre_carrera, division_academica_id_division_academica from carrera join division_academica on division_academica_id_division_academica = id_division_academica where id_division_academica = ?;";
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, id_division_academica);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Carrera carrera = new Carrera();
                carrera.setId_carrera(rs.getInt("id_carrera"));
                carrera.setCarrera(rs.getString("nombre_carrera"));
                carrera.setId_division_academica(rs.getInt("division_academica_id_division_academica"));
                carreras.add(carrera);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return carreras;
    }

    public Carrera getById(int id) {
        Carrera carrera = new Carrera();
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            String query = "SELECT  nombre_carrera FROM carrera WHERE id_carrera=?";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            ps.setInt(1, id);
            if (rs.next()) {
                carrera = new Carrera();
                carrera.setId_carrera(rs.getInt("id_carrera"));
                carrera.setCarrera(rs.getString("nombre_carrera"));
                carrera.setId_division_academica(rs.getInt("division_academica_id_division_academica"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return carrera;
    }

    public Carrera getAllByGrupo(int id) {
        Carrera carrera = new Carrera();
        DivisionAcademica divisionAcademica = new DivisionAcademica();
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            String query = "SELECT  nombre_carrera FROM carrera WHERE id_carrera=?";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            ps.setInt(1, id);
            if (rs.next()) {
                carrera = new Carrera();
                carrera.setId_carrera(rs.getInt("id_carrera"));
                carrera.setCarrera(rs.getString("nombre_carrera"));
                carrera.setId_division_academica(rs.getInt("division_academica_id_division_academica"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return carrera;
    }
}
