package mx.edu.utez.sice.dao;

import mx.edu.utez.sice.model.DivisionAcademica;
import mx.edu.utez.sice.model.Carrera;
import mx.edu.utez.sice.utils.DatabaseConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
//se agrego Dao para division
public class DivisionAcademicaDao {

    public ArrayList<DivisionAcademica> getAll() {
        ArrayList<DivisionAcademica> lista = new ArrayList<>();
        try (Connection con = DatabaseConnectionManager.getConnection()) {
            String query = "SELECT * FROM division_academica";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DivisionAcademica division = new DivisionAcademica();
                division.setId_division_academica(rs.getInt("id_division_academica"));
                division.setDivision_academica(rs.getString("nombre_division_academica"));
                lista.add(division);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
    public DivisionAcademica getById(int id) {
        DivisionAcademica division = new DivisionAcademica();
        try {
            Connection con = DatabaseConnectionManager.getConnection();
            String query = "SELECT * FROM division_academica WHERE id_division_academica=?";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            ps.setInt(1, id);
            if (rs.next()) {
                division = new DivisionAcademica();
                division.setId_division_academica(rs.getInt("id_division_academica"));
                division.setDivision_academica(rs.getString("nombre_division_academica"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return division;
    }
}

